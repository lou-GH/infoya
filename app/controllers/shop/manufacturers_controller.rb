class Shop::ManufacturersController < ApplicationController
  before_action :set_manufacturer,only: %i[edit update]

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
    @locations = current_manufacturer.locations
  end

  def edit
    @manufacturer = current_manufacturer
  end

  def update
    @manufacturer = current_manufacturer
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = "You have updated manufacturer successfully."
      redirect_to shop_manufacturers_my_page_path
    else
      render :edit
    end
  end

private

    def set_manufacturer
        @manufacturer = Manufacturer.find(current_manufacturer.id)
    end

    def manufacturer_params
        params.require(:manufacturer).permit(:email,:account_name,:introduction,:prefecture)
    end

end
