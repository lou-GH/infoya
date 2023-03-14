class Public::RelationshipsController < ApplicationController

  # フォローアンフォロー処理
  def create
    # params[:user_id]はリンクから送られてきたuser_idをparamsで受け取っている
    # そして受け取った値をモデルのメソッドに受け渡している
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    current_user.follow(params[:manufacturer_id])
    #フォローの通知機能
    # @user.create_notification_follow!(current_user)
    # redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:manufacturer_id])
    redirect_to request.referer
  end

  # フォローフォロワー一覧処理
  def followings
    manufacturer = Manufacturer.find(params[:manufacturer_id])
    @manufacturers = manufacturer.relationships
  end



end
