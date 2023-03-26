class Admin::ManufacturersController < ApplicationController

  def show
    @manufacturer = Manufacturer.find(params[:id])
    # @locations = @manufacturer.locations
  end

  def index
    # @manufacturers = Manufacturer.all
    # 検索オブジェクト
    @search = Manufacturer.ransack(params[:q])
    # 検索結果
    @manufacturers = @search.result.page(params[:page]).per(20)
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_manufacturer_path(@manufacturer.id)
  end

private

  def manufacturer_params
    params.require(:manufacturer).permit(:manufacturer_status)
  end

end
