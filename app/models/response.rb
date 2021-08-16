class Response < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :user, presence: true
  validates :post, presence: true
  validates :content, presence: true, unless: :image?, length: { maximum: 500 }
  mount_uploader :image, ImageUploader
end
