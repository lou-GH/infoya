class Admin::UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_user_path(@user.id)
  end

  def index
    # 検索オブジェクト
    @search = User.ransack(params[:q])
    # 検索結果
    @users = @search.result.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
  end

private

  def user_params
    params.require(:user).permit(:user_status)
  end

end
