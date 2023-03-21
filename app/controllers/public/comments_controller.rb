class Public::CommentsController < ApplicationController

  def create
    # post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    # comment.post_id = post.id
    if comment.save
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      # @post.create_notification_by(current_user)
      flash[:notice] = "コメントしました。"
      redirect_to public_post_path(@post)
    else
      @posts = Post.all
      @user = current_user
      render template: "public/posts/show"
    end

    # @post.create_notification_by(current_user)
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to public_post_path(params[:post_id])
  end

private
  def comment_params
    params.permit(:comment).merge(post_id: params[:post_id])
    #form tagにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。URLを作るために。
  end

end
