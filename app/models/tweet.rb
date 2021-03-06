class Tweet < ApplicationRecord
  validates :text, presence: true, unless: :image?

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  mount_uploader :image, ImageUploader

  def self.search(search)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else 
      Tweet.all
    end
  end
end
