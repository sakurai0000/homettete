class Post < ApplicationRecord
  validates :post, {length: {in: 1..200} }

  has_one_attached :image
  belongs_to :user
  has_many :amazings, dependent: :destroy
  has_many :greats, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  #has_many :image, dependent: :destroy



  def get_image
    #unless image.attached?
     # file_path = Rails.root.join('app/assets/images/no_image.jpg')
     # image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #end
    image
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def greatd_by?(user)
    greats.exists?(user_id: user.id)
  end

  def amazingd_by?(user)
    amazings.exists?(user_id: user.id)
  end

  # サーチ用メソッド
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("post LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("post LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("post LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("post LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  # いいね通知用メソッド
  def create_notification(current_user,type)
    notification = current_user.active_notifications.new(
      comment_id: nil,
      post_id: id,
      visited_id: user_id,
      action: type
      )
    if notification.visitor_id == notification.visited_id
       notification.checked = true
    end
    notification.save if notification.valid?
  end




  # コメント通知用メソッド
  def create_notification_comment(current_user, comment_id)
    #byebug
    temp_ids = Comment.where(post_id: id).select(:user_id).where.not("user_id = ? or user_id = ?", current_user.id, user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment(current_user, comment_id, user_id)
  end

  def save_notification_comment(current_user, comment_id, visited_id)#(通知をした人,通知されたコメント,通知された人)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end




end
