class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :render_notifications
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def render_notifications
    if user_signed_in?
  	  @notifications = Notification.where("user_id=?", current_user.id).reverse
    end
  end

end
