
class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_filter :configure_permitted_parameters, if: :devise_controller?

    layout :layout_by_resource

	protected

	def layout_by_resource
	  if devise_controller? && resource_name == :employer
	    "employer"
	  elsif devise_controller? && resource_name == :student
	    "student"
	  else
	    "application"
	  end
	end

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :birthday, :company, :position, :grad_year, :password_confirmation) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :birthday, :current_password, :company, :position, :grad_year) }
        end
end