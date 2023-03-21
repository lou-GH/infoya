class Public::ManufacturersController < ApplicationController

  def show
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @locations = @manufacturer.locations
  end

  def index
    # @manufacturers = Manufacturer.all
    # 検索オブジェクト
    @search = Manufacturer.ransack(params[:q])
    # 検索結果
    @manufacturers = @search.result.page(params[:page]).per(20)
  end

end
