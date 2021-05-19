class Post < ApplicationRecord
  # 投稿にタグつけたい
  acts_as_taggable_on :tag_list
  acts_as_taggable

  mount_uploaders :image, ImageUploader
  serialize :image, JSON # SQLiteを使っているときはこの列を追記

  belongs_to :user
  # attachment :image 'carrierwave'導入時にコメントアウト
  has_many :post_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search,word)
    if search == "forward_match"
      @post = Post.where("body LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("body LIKE?","%#{word}")
    elsif search == "perfect_match"
      @post = Post.where("#{word}")
    elsif search == "partial_match"
      @post = Post.where("body LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end
