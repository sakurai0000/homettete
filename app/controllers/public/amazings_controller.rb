class Public::AmazingsController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def create
    @post = Post.find(params[:post_id])
    amazing = current_user.amazings.new(post_id: @post.id)
    if amazing.save
      @post.create_notification(current_user, "amazing")
    end
    # redirect_to post_path(post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    amazing = current_user.amazings.find_by(post_id: @post.id)
    amazing.destroy
    # redirect_to post_path(post)
  end


  def index
    # binding.pry
    @user = User.find(params[:post_id])
    amazings = Amazing.where(user_id: @user.id).pluck(:post_id)
    @amazing_posts = Post.where(id: amazings).page(params[:page]).per(10).order(created_at: :desc)
  end
end
