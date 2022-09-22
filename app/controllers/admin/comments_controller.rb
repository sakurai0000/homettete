class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @comment.destroy if @comment
    redirect_to admin_post_path(@post)
  end
end
