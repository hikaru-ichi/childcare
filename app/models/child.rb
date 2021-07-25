class Child < ApplicationRecord
  belongs_to :user
  
  validates :child_birth, presence: true
  validates :child_gender, presence: true
end
