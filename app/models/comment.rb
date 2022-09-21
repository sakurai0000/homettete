class Comment < ApplicationRecord
  validates :comment, { length: { in: 1..200 } }

  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
end
