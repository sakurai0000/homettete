class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def index
    @notifications = current_user.passive_notifications #ユーザが受け取る通知の全て
    @notifications.where(checked: false).each do |notification| #indexページを開いた瞬間に通知のcheckedは全てtrueに変える
      notification.update(checked: true)
    end
  end


  def destroy
    @notifications =current_user.passive_notifications.destroy_all #
    redirect_to user_notifications_path
  end


end
