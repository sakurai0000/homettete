class Public::LikesController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)
    like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to post_path(post)
  end
  
  def index
    #binding.pry
    @user = User.find(params[:post_id])
    likes= Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
  

end
