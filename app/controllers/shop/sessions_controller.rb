# frozen_string_literal: true

class Shop::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_manufacturer, only: [:create]


  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

   # 退会しているかを判断するメソッド
  def reject_manufacturer
    @manufacturer = Manufacturer.find_by(email: params[:manufacturer][:email])
    if @manufacturer
      if @manufacturer.valid_password?(params[:manufacturer][:password])
        if @manufacturer.is_deleted
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
          redirect_to new_manufacturer_registration_path
        end
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
