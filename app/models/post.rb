class Post < ApplicationRecord

  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :favorited_members, through: :favorites, source: :member

  has_one_attached :outfit_image

  validates :outfit_image, presence: true
  validates :title, presence: true
  validates :body, length:{maximum:400}
  
  # いいねされているかどうか
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
