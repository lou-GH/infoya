class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications
    # .(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    # 通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to public_notifications_path
  end

end
