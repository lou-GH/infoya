class Shop::NotificationsController < ApplicationController

  def index
    @notifications = current_manufacturer.passive_notifications.(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    # 通知を全削除
    @notifications = current_manufacturer.passive_notifications.destroy_all
    redirect_to shop_notifications_path
  end

end
