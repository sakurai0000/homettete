class Public::GreatsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def create
    @post = Post.find(params[:post_id])
    great = current_user.greats.new(post_id: @post.id)
    if great.save
      @post.create_notification(current_user, "great")
    end
    # redirect_to post_path(post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    great = current_user.greats.find_by(post_id: @post.id)
    great.destroy
    # redirect_to post_path(post)
  end

  def index
    # binding.pry
    @user = User.find(params[:post_id])
    greats = Great.where(user_id: @user.id).pluck(:post_id)
    @great_posts = Post.where(id: greats).page(params[:page]).per(10).order(created_at: :desc)
  end
end
