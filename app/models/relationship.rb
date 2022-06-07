class Relationship < ApplicationRecord
  
  belongs_to :following, class_name: :member
  belongs_to :follower, class_name: :member
  
end
