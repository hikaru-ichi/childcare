class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :birth, presence: true
  validates :gender, presence: true
  has_secure_password
  
  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true
  
  validates :children, presence: true
  validates_associated :children
  
  has_many :messages
  has_many :posts

end
