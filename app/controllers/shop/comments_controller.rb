class Shop::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_manufacturer.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      @post.create_notification_by(current_manufacturer)
      flash[:notice] = "コメントしました。"
      redirect_to shop_post_path(@post.id)
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

end
