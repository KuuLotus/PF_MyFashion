class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :following
  has_one_attached :profile_image

  validates :body, length:{maximum:2000}

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_user.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  def get_gender
    if gender == 0
      "男性"
    elsif gender == 1
      "女性"
    end
  end

  def get_height
    if height.present?
      "#{height}" + "cm"
    end
  end

  def followed_by?(member)
    reverse_of_relationships.find_by(following_id: member.id).present?
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(name: "企業様(閲覧用)" ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "企業様(閲覧用)"
    end
  end

end
