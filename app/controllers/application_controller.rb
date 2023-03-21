class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admin_posts_path
    elsif resource_or_scope.is_a?(User)
        public_followings_path(resource_or_scope)
    elsif resource_or_scope.is_a?(Manufacturer)
        shop_posts_path(resource_or_scope)
    else
        root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
        root_path
    elsif resource_or_scope == :manufacturer
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end

  def admin_url
    request.fullpath.include?("/admin")
  end


  protected

  def configure_permitted_parameters
    added_attrs = [ :account_name, :email, :encrypted_password, :prefecture, :user_icon, :is_deleted ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
