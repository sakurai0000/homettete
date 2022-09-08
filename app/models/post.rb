class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :amazings, dependent: :destroy
  has_many :greats, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
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




end
