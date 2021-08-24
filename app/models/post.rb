class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  has_many :responses, dependent: :destroy
  validates :user, presence: true
  validates :category, presence: true
  validates :title, presence: true, length: { maximum: 15 }
  validates :content, presence: true, unless: :image?, length: { maximum: 500 }
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
  

  def self.search(search_keyword)
    where(["title like? OR name like?", "%#{search_keyword}%", "%#{search_keyword}%"])
  end

end
