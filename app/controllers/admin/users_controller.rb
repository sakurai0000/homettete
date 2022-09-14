class Admin::UsersController < ApplicationController
  def index
    @users =User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(20).order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end


  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
