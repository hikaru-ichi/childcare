class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  validates :title, presence: true
  validates :content, presence: true, unless: :image?
  mount_uploader :image, ImageUploader
  
  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'category'
      return all.includes(:category).order("categories.name desc")
    end
  end
end
