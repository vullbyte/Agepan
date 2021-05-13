class Relationship < ApplicationRecord
  # フォローされてる人
  belongs_to :user
  # フォローしてる人
  belongs_to :follower, class_name: 'User'
end
