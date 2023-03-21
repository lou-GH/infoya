class Admin::PostsController < ApplicationController

  def index
    @genre_list = Genre.all
    @posts = Post.all
    # @post = Post.new
    # @manufacturer = manufacturer
    # @manufacturer = @post.manufacturer
    # @posts = @manufacturer.posts
    # @post = Post.find(params[:id])
    # @genre_list = @posts.genres

    # 検索オブジェクト
    @search = Genre.ransack(params[:q])
    # 検索結果
    @genres = @search.result.page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
    @manufacturer = @post.manufacturer
    @post_genres = @post.genres
    @comments = @post.comments
    @comment = Comment.new

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      @posts = Post.all
      redirect_to admin_posts_path, flash: {danger: "投稿を削除しました"}
    else
      @posts = Post.all
      render :index
    end
  end

private

  def post_params
    params.require(:post).permit(:introduction, :post_image, :location_id)
  end

  def comment_params
    params.require(:comment).permit(:comment).merge.(manufacturer_id: manufacturer.id)
  end

end
