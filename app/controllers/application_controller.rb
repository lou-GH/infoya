class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [ :account_name, :email, :encrypted_password, :prefecture, :user_icon, :is_deleted ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
