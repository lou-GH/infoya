class Shop::ManufacturersController < ApplicationController
  def unsubscribe
    @manufacturer = current_manufacturer
  end

  def withdraw
    @manufacturer = current_manufacturer
    @manufacturer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def show
    @location = Location.new
    @locations = current_manufacturer.location_id
  end

  def edit
    @manufacturer = current_manufacturer
  end

  def update
    @manufacturer = current_manufacturer
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = "You have updated manufacturer successfully."
      redirect_to manufacturers_my_page_path
    else
      render :edit
    end
  end

end