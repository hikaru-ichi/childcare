class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :gender, presence: true, inclusion: { in: ['男性', '女性'] }
  validates :birth, presence: true
  validate :birth_future_date?
  has_secure_password
  
  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true
  
  validates :children, presence: true
  validates_associated :children
  
  has_many :messages
  has_many :posts
  has_many :responses
  
  private
  
  def birth_future_date?
    # 生年月日が入力済かつ未来日(現在日付より未来)
    if birth.present? && birth > Date.today
      # エラー対象とするプロパティ(birthday)とエラーメッセージを設定
      errors.add(:birth, "生年月日に未来日は指定できません")
    end
  end

end
