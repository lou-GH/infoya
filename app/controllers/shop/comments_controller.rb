class Shop::CommentsController < ApplicationController

  def create
    comment = current_manufacturer.comments.new(comment_params)
    if comment.save
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      # @post.create_notification_by(current_manufacturer)
      flash[:notice] = "コメントしました。"
      redirect_to shop_post_path(@post)
    else
      @manufacturer = current_manufacturer
      @posts = @manufacturer.posts
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
