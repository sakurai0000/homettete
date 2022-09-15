# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def user_state
    @user = User.find_by(email: params[:user][:email])  #emailからuserを探す
    if @user   #もしアカウントが見つかれば
      if @user.valid_password?(params[:user][:password]) && @user.user_status
      #@userのパスワードが有効かつ退会済み(user_status == true)ならば
        flash[:notice] = 'お客様のアカウントは現在ご使用できません。'
        redirect_to new_user_registration_path 
      end
    end
  end
  
  
  
end
