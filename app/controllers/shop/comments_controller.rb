class Shop::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_manufacturer.comments.new(comment_params)
    byebug
    if comment.save
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      @post.create_notification_by(current_manufacturer)
      flash[:notice] = "コメントしました。"
      redirect_to shop_post_path(@post)
    else
      @manufacturer = current_manufacturer
      @posts = @manufacturer.posts
      render template: "shop/posts/show"
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "Comment updated"
      redirect_to @post
    else
      flash[:danger] = "Comment failed"
      render template: "shop/posts/show"
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to shop_post_path(params[:post_id])
  end

private
  def comment_params
    params.permit(:comment).merge(post_id: params[:post_id])
    #form tagにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。URLを作るために。
  end

end
