class Shop::PostsController < ApplicationController

before_action :correct_user ,only:[:edit, :update, :destroy]

  def search
    @genre_list = Genre.all
    @genre = Genre.find(params[:ganre_id])
    @posts = @genre.posts.all
  end

  def index
    @genre_list = Genre.all
    @posts = Post.all
    @post = Post.new
    @manufacturer = current_manufacturer
  end

  def new
    @post = current_manufacturer.posts.new
  end

  def create
      # Rails.logger.info "**********【#{params.inspect}】**********"
      # genre = Genre.new
      # genre.genre_name = params[:genre_name]
    # パラメーターを受け取り保存準備
    @post = current_manufacturer.posts.new(post_params)


    @post.manufacturer_id = current_manufacturer.id
    # genre_list = params[:post][:genre_name].split(nil)

    # Postを保存
    if @post.save
      # タグの保存
      @post.save_genres(params[:post][:genre])
      # @post.save_genre(genre_list)
      @post.create_notification_by(current_manufacturer)
      flash[:notice] = "投稿しました。"
      # 成功したら投稿詳細へリダイレクト
      redirect_to shop_post_path(@post.id)
    else
      @posts = Post.all
      @manufacturer = current_manufacturer
      # 失敗した場合は、newへ戻る
      render :new
    end

    comment = current_manufacturer.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      @post.create_notification_by(current_manufacturer)
      flash[:notice] = "コメントしました。"
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
    @genre_tags = @post.genres
    @comment = Comment.new

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      @posts = Post.all
      redirect_to shop_posts_path, flash: {danger: "投稿を削除しました"}
    else
      @posts = Post.all
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:introduction, :post_image, :location_id, :genre_name)
  end

  def correct_manufacturer
    @post = Post.find(params[:id])
    unless @post.manufacturer == current_manufacturer
      redirect_to shop_posts_path
    end
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
