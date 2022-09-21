class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, {uniqueness: true}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :amazings, dependent: :destroy
  has_many :greats, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reports, dependent: :destroy
  
  # 通報機能
  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  
  # 通知機能用
  has_many :active_notifications, class_name: "Notification", foreign_key:"visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key:"visited_id", dependent: :destroy
    
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  
# プロフ画像用
  has_one_attached :profile_image
def get_profile_image(width, height)
 unless profile_image.attached?
  file_path = Rails.root.join('app/assets/images/no_image.png')
  profile_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
 end
  profile_image.variant(gravity: :center, resize: "#{width}x#{height}^", crop: "#{width}x#{height}+0+0").processed
end

 # サーチ機能
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
 # フォロー通知メソッド
  def create_notification_follow(current_user)
    notification = current_user.active_notifications.new(
      visited_id: id, 
      action: 'follow'
    )
    notification.save if notification.valid?
  end
  
  # ゲストログインメソッド
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end


end
