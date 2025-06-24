module Api::V1
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: %i[show update]
    before_action :authorize_client!,     only: [:create]
    before_action :authorize_participant!, only: %i[show update]

    def index
      orders = if current_user.client?
                 Order.for_client(current_user)
               else
                 Order.for_freelancer(current_user)
               end
      orders = orders.recent.page(params[:page]).per(20)
      render json: orders, each_serializer: OrderSerializer, meta: pagination_meta(orders)
    end

    def show
      render json: @order, serializer: OrderSerializer
    end

    def create
      gig = Gig.find(order_params[:gig_id])
      order = current_user.orders_as_client.build(
        gig: gig,
        freelancer: gig.freelancer,
        price_cents: gig.price_cents
      )
      if order.save
        OrderMailer.order_confirmation(order.id).deliver_later
        render json: order, status: :created, serializer: OrderSerializer
      else
        render_validation_errors(order)
      end
    end

    # Used by freelancer to update status or by client to cancel
    def update
      desired = order_params[:status]&.to_sym
      case desired
      when :accepted
        return forbidden unless @order.pending? && current_user.freelancer?
        @order.accepted!
      when :in_progress
        return forbidden unless @order.accepted? && current_user.freelancer?
        @order.in_progress!
      when :completed
        return forbidden unless @order.in_progress? && current_user.freelancer?
        @order.completed!
      when :cancelled
        return forbidden unless @order.pending? && current_user.client?
        @order.cancelled!
      else
        return render_error("Invalid status transition", :unprocessable_entity)
      end

      render json: @order, serializer: OrderSerializer
    end

    private

    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error("Order not found", :not_found)
    end

    def order_params
      params.require(:order).permit(:gig_id, :status)
    end

    def authorize_client!
      render_error("Only clients can place orders", :forbidden) unless current_user.client?
    end

    def authorize_participant!
      allowed = current_user.client? ? @order.client_id == current_user.id : @order.freelancer_id == current_user.id
      render_error("Forbidden", :forbidden) unless allowed
    end

    def forbidden
      render_error("Forbidden action", :forbidden) and return
    end

    def render_error(message, status)
      render json: { error: message }, status: status
    end

    def render_validation_errors(record)
      render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
    end

    def pagination_meta(collection)
      {
        current_page: collection.current_page,
        next_page:    collection.next_page,
        total_pages:  collection.total_pages,
        total_count:  collection.total_count
      }
    end
  end
end