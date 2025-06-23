module Api::V1
  class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_client!, only: [:create]

    def index
      reviews = if params[:freelancer_id].present?
                  Review.joins(:order).where(orders: { freelancer_id: params[:freelancer_id] })
                else
                  Review.all
                end
      reviews = reviews.order(created_at: :desc).page(params[:page]).per(20)
      render json: reviews, each_serializer: ReviewSerializer, meta: pagination_meta(reviews)
    end

    # POST /api/v1/reviews
    def create
      review = current_user.orders_as_client.find_by(id: review_params[:order_id])&.build_review(
        rating: review_params[:rating],
        comment: review_params[:comment]
      )

      return render_error("Order not found or not yours", :forbidden) unless review

      if review.save
        render json: review, status: :created, serializer: ReviewSerializer
      else
        render_validation_errors(review)
      end
    end

    private

    def review_params
      params.require(:review).permit(:order_id, :rating, :comment)
    end

    def authorize_client!
      render_error("Only clients can leave reviews", :forbidden) unless current_user.client?
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
