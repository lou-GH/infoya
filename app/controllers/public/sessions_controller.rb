# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

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

  def new_guest
    user = User.guest
    sign_in user   # ユーザーをログインさせる
    redirect_to public_posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

 # 退会しているかを判断するメソッド
  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password])
        if @user.is_deleted
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
          redirect_to new_user_registration_path
        end
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
