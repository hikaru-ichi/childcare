class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :reciever, class_name: 'User'
  
  validates :sender, presence: true
  validates :reciever, presence: true
  validates :content, presence: true, unless: :image?, length: { maximum: 500 }
  mount_uploader :image, ImageUploader
end
