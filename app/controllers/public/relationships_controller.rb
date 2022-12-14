class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def create
    current_user.follow(params[:user_id])
    current_user.create_notification_follow(current_user, params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
