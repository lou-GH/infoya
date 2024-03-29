class Public::UsersController < ApplicationController
  before_action :set_user,only: %i[edit update]

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def show

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to public_users_my_page_path
    else
      render :edit
    end
  end

private

    def set_user
        @user = User.find(current_user.id)
    end

    def user_params
        params.require(:user).permit(:email,:account_name,:introduction,:prefecture,:user_icon)
    end

end
