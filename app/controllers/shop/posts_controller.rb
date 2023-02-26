class Shop::PostsController < ApplicationController

  def index
    @post = Post.all
  end

  def new
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
  end

  def create
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @manufacturer.posts.create(post_params)
    redirect_to posts_index_path
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
    redirect_to "/",flash: {danger: "投稿を削除しました"}
    end
  end

  private

  def post_params
    params.require(:post).permit(:introduction, :post_image)
  end

end
