class Shop::GenresController < ApplicationController

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def destroy
    Genre.find(params[:id]).destroy()
    redirect_to shop_genres_path
  end

end
