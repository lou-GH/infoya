class Public::ManufacturersController < ApplicationController

  def show
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @locations = @manufacturer.locations
  end

  def index
    @manufacturers = Manufacturer.all
  end

end
