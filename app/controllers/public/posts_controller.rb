class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.includes(:comments).page(params[:page]).per(10).order(created_at: :desc)
  end

  def friends
    @posts = Post.where(user_id: [*current_user.following_ids]).page(params[:page]).per(10).order(created_at: :desc)
  end


  def show
    @post = Post.find(params[:id])
    @post_comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def post_params
    params.require(:post).permit(:post, :image)
  end
end
