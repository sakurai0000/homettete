class Admin::PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments).page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_path(@post.user)
  end
  
  
  def post_params
    params.require(:post).permit(:post, :image)
  end
end
