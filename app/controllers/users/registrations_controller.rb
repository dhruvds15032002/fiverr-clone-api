# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      sign_in(resource) # triggers warden so JWT dispatch hook works
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        user: resource
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "User couldn't be created" },
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
