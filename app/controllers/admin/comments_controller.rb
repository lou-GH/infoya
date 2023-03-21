class Admin::CommentsController < ApplicationController

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end

private
  def comment_params
    params.permit(:comment).merge(post_id: params[:post_id])
    #form tagにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。URLを作るために。
  end

end
