class Shop::LocationsController < ApplicationController

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @location = Location.new(location_params)
    @location.manufacturer_id = current_manufacturer.id
    if @location.save
      flash[:notice] = "Location was successfully created."
      @locations = current_manufacturer.locations
      # マイページへ
      redirect_to shop_manufacturers_my_page_path
    else
      @location = Location.new
      @locations = current_manufacturer.locations
      # マイページへ
      render template: "shop/manufacturers/show"
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      flash[:notice] = "Location  was successfully updated."
      @locations = current_manufacturer.locations
      # マイページへ
      redirect_to shop_manufacturers_my_page_path
    else
      @locations = current_manufacturer.locations
      # 編集ページを再表示
      render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.destroy
      flash[:notice] = "Location  was successfully destroyed."
      @locations = current_manufacturer.locations
      # マイページへ
      redirect_to root_path
    else
      @locations = current_manufacturer.locations
      # マイページへ
      render template: "shop/manufacturers/show"
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :postal_code, :prefecture, :address, :location_image, :introduction)
  end

end
