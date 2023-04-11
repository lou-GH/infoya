class Public::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @manufacturer = @post.manufacturer
    @post_genres = @post.genres
    @comments = @post.comments
    @comment = Comment.new

  end

  def index
    @user = current_user
    @manufacturers = Manufacturer.all
    @posts = Post.all.order(created_at: :desc)

    # 検索オブジェクト
    @search = Genre.ransack(params[:q])
    # 検索結果
    @genres = @search.result.page(params[:page]).per(20)
  end

private

  def comment_params
    params.require(:comment).permit(:comment).merge.(user_id: current_user.id)
  end

end
