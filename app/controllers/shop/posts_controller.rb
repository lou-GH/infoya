class Shop::PostsController < ApplicationController

before_action :correct_manufacturer ,only:[:edit, :update, :destroy]

  def search
    @genre_list = Genre.all.order(created_at: :desc)
    @genre = Genre.find(params[:ganre_id])
    @posts = @genre.posts.all.order(created_at: :desc)
    # /shop/genres/:genre_id/posts(.:format)
  end

  def index
    @genre_list = Genre.all.order(created_at: :desc)
    # @posts = Post.all
    # @post = Post.new
    @manufacturer = current_manufacturer
    @posts = @manufacturer.posts.order(created_at: :desc)
    # @post = Post.find(params[:id])
    # @manufacturer = @post.manufacturer
    # @genre_list = @posts.genres
    # @post_genres = @post.genres
  end

  def new
    @post = current_manufacturer.posts.new
    @post.genre_tags.build
  end

  def create
    # パラメーターを受け取り保存準備
    @post = current_manufacturer.posts.new(post_params)

    @post.manufacturer_id = current_manufacturer.id

    genre_list = params[:post][:genre_name].split(nil)

    # Postを保存
    # if @post.valid?
    if @post.save
      # タグの保存
      # @post.genre_tags.each do |genre|
      @post.save_genres(genre_list)
      # end
      # @post.save_genre(genre_list)
      # @post.save
      @post.create_notification_by(current_manufacturer)
      flash[:notice] = "投稿しました。"
      # 成功したら投稿詳細へリダイレクト
      redirect_to shop_posts_path
    else
      # @posts = Post.all
      @manufacturer = current_manufacturer
      @posts = @manufacturer.posts.order(created_at: :desc)
      # 失敗した場合は、newへ戻る
      render :new
    end

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
      @posts = Post.all.order(created_at: :desc)
      redirect_to shop_posts_path, flash: {danger: "投稿を削除しました"}
    else
      @posts = Post.all.order(created_at: :desc)
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:introduction, :post_image, :location_id)
  end

  def correct_manufacturer
    @post = Post.find(params[:id])
    unless @post.manufacturer == current_manufacturer
      redirect_to shop_posts_path
    end
  end

  def comment_params
    params.permit(:comment).merge(post_id: params[:post_id])
  end

end
