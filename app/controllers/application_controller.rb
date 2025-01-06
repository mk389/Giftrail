class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :residence, :password, :password_confirmation, :icon])
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def not_found
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end
end
