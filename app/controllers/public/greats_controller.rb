class Public::GreatsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    great = current_user.greats.new(post_id: post.id)
    great.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    great = current_user.greats.find_by(post_id: post.id)
    great.destroy
    redirect_to post_path(post)
  end

  
end
