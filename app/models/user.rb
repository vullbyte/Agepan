class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attachment :profile_image

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローしてる人
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower

  # フォローされてる人
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :user
  has_many :followers, through: :passive_relationships, source: :user

  def follow(other_user)
    return if self == other_user

    relationships.find_or_create_by!(follower: other_user)
  end

  def following?(user)
    followings.include?(user)
  end

  def unfollow(relathinoship_id)
    relationships.find(relathinoship_id).destroy!
  end

  def self.search(search, word)
    @user = if search == 'forward_match'
              User.where('name LIKE?', "#{word}%")
            elsif search == 'backward_match'
              User.where('name LIKE?', "%#{word}")
            elsif search == 'perfect_match'
              User.where(word.to_s)
            elsif search == 'partial_match'
              User.where('name LIKE?', "%#{word}%")
            else
              User.all
            end
  end

  # is_deletedがfalseならtrueを返す。
  def active_for_authentication?
    super && (is_deleted == false)
  end

  protected

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        flash[:notice] = '退会済みです。再度ご登録をしてご利用ください。'
        redirect_to new_user_registration
      else
        flash[:notice] = '項目を入力してください'
      end
    end
  end
end
