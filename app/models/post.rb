class Post < ApplicationRecord

  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  
  has_one_attached :outfit_image
  

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
end
