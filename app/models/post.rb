class Post < ApplicationRecord
  # 投稿にタグつけたい
  acts_as_taggable_on :tag_list
  acts_as_taggable

  mount_uploaders :image, ImageUploader
  serialize :image, JSON # SQLiteを使っているときはこの列を追記

  belongs_to :user
  # attachment :image  <- carrierwave導入時にコメントアウト
  has_many :post_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search, word)
    @post = if search == 'forward_match'
              Post.where('body LIKE?', "#{word}%")
            elsif search == 'backward_match'
              Post.where('body LIKE?', "%#{word}")
            elsif search == 'perfect_match'
              Post.where(word.to_s)
            elsif search == 'partial_match'
              Post.where('body LIKE?', "%#{word}%")
            else
              Post.all
            end
  end

  # NGワード作成
  NGWORD = %w(クソ野郎 糞　)
  NGWORD_REGEX = %r(#{NGWORD.join('|')})
  validates :body, format: { with: NGWORD_REGEX}

end
