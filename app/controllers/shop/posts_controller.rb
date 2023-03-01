class Shop::PostsController < ApplicationController

before_action :correct_user ,only:[:edit, :update, :destroy]

  def index
    @post = Post.all
    @manufacturer = current_manufacturer
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.manufacturer_id = current_manufacturer.id
    if @post.save
      flash[:notice] = "投稿完了しました。"
      redirect_to shop_post_path(@post.id)
    else
      @posts = Post.all
      @manufacturer = current_manufacturer
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @manufacturer = @post.manufacturer
    @post_new = Post.new
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to shop_posts_path, flash: {danger: "投稿を削除しました"}
    else
      @posts = Post.all
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:introduction, :post_image)
  end

  def correct_manufacturer
    @post = Post.find(params[:id])
    unless @post.manufacturer == current_manufacturer
      redirect_to shop_posts_path
    end
  end

end
