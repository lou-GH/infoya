class Shop::PostsController < ApplicationController

before_action :correct_manufacturer ,only:[:edit, :update, :destroy]

  def search
    @genre_list = Genre.all.order(created_at: :desc)
    @genre = Genre.find(params[:ganre_id])
    @posts = @genre.posts.all.order(created_at: :desc)
  end

  def index
    @genre_list = Genre.all.order(created_at: :desc)
    @manufacturer = current_manufacturer
    @posts = @manufacturer.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @post = current_manufacturer.posts.new
    @post.genre_tags.build
  end

  def create
    # パラメーターを受け取り保存準備
    @post = current_manufacturer.posts.new(post_params)
    @post.manufacturer_id = current_manufacturer.id
    # Postを保存
    if @post.save
      # タグの保存
      genre_list = genre_params[:genre_name].split(/[[:blank:]]+/).select(&:present?)
      @post.save_genres(genre_list)
      @post.create_notification_by(current_manufacturer)
      flash[:notice] = "投稿しました。"
      # 成功したら投稿詳細へリダイレクト
      redirect_to shop_posts_path
    else
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

  # タグ用にストロングパラメータを設定して、文字列を受け取る
  def genre_params
    params.require(:post).permit(:genre_name)
  end

end
