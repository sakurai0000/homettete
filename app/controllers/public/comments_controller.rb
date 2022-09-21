class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    # byebug
    if @post_comment.save
      @post.create_notification_comment(current_user, @post_comment.id)
      redirect_to post_path(@post)
    else
      render template: "public/posts/show"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end


  def post_comment_params
    params.require(:comment).permit(:comment)
  end
end
