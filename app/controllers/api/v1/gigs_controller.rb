module Api::V1
  class GigsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_gig,          only: %i[show update destroy]
    before_action :authorize_freelancer!, only: %i[create update destroy]

    def index
      gigs = Gig.search(params[:q]).recent.page(params[:page]).per(20)
      render json: gigs,
             each_serializer: GigSerializer,
             meta: pagination_meta(gigs)
    end

    def show
      render json: @gig, serializer: GigSerializer
    end

    def create
      gig = current_user.gigs.build(gig_params)
      if gig.save
        render json: gig, status: :created, serializer: GigSerializer
      else
        render_validation_errors(gig)
      end
    end

    def update
      if @gig.update(gig_params)
        render json: @gig, serializer: GigSerializer
      else
        render_validation_errors(@gig)
      end
    end

    def destroy
      @gig.destroy
      head :no_content
    end


    private

    def set_gig
      @gig = Gig.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error("Gig not found", :not_found)
    end

    def gig_params
      params.require(:gig).permit(:title, :description, :price_cents)
    end

    def authorize_freelancer!
      render_error("Only freelancers can perform this action", :forbidden) \
        unless current_user.role == "freelancer"
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
        prev_page:    collection.prev_page,
        total_pages:  collection.total_pages,
        total_count:  collection.total_count
      }
    end
  end
end