class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
    status: { code: 200, message: 'Signed in successfully.' },
    user: resource
  }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end
end
