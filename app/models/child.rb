class Child < ApplicationRecord
  belongs_to :user
  
  validates :user, presence: true
  validates :child_birth, presence: true
  validates :child_gender, presence: true, inclusion: { in: ['男性', '女性'] }
end
