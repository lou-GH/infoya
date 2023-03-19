class Shop::PostsController < ApplicationController

before_action :correct_manufacturer ,only:[:edit, :update, :destroy]

  def search
    @genre_list = Genre.all
    @genre = Genre.find(params[:ganre_id])
    @posts = @genre.posts.all
    # /shop/genres/:genre_id/posts(.:format)
  end

  def index
    @genre_list = Genre.all
    # @posts = Post.all
    # @post = Post.new
    @manufacturer = current_manufacturer
    @posts = @manufacturer.posts
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
      # Rails.logger.info "**********【#{params.inspect}】**********"
      # genre = Genre.new
      # genre.genre_name = params[:genre_name]

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
      @posts = @manufacturer.posts
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
    # @location = Locations.find(params[:post][:location_id])
    # @post.location_prefecture = @location.prefecture
    # @post.location_name = @location.name
    # @post.location_postal_code = @location.postal_code
    # @post.location_address = @location.address
    # @post.location_locaｗｑ２ｗ３post.location_locaｗｑ２ｗ３tion_image = @location.location_location_image
    # @post.location_introduction = @location.introduction
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
    params.require(:post).permit(:introduction, :post_image, :location_id)
  end

  def correct_manufacturer
    @post = Post.find(params[:id])
    unless @post.manufacturer == current_manufacturer
      redirect_to shop_posts_path
    end
  end

  def comment_params
    params.require(:comment).permit(:comment).merge.(manufacturer_id: current_manufacturer.id)
  end

end
