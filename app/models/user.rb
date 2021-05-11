class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image

  validates :name, presence: true #追記
  validates :profile, length: { maximum: 200 } #追記

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
end
