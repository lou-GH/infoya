class Shop::LocationsController < ApplicationController

  # def index
    # @location = Location.new
    # @locations= current_manufacturer.locations
  # end

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @location = Location.new(location_params)
    @location.customer_id = current_manufacturer.id
    if @location.save
      flash[:notice] = "Location was successfully created."
      @locations = current_manufacturer.locations
      # マイページへ
      redirect_to locations_path
    else
      @locations = current_manufacturer.locations
      # マイページへ
      render :home
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      flash[:notice] = "Location  was successfully updated."
      @locations = current_manufacturer.locations
      # マイページへ
      redirect_to root_path
    else
      @locations = current_manufacturer.locations
      # マイページへ
      render :home
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
      render :home
    end
  end

  private

  def location_params
      params.require(:location).permit(:name, :postal_code, :prefecture, :address, :location_image, :introduction)
  end

end
