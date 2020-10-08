class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # パスワードの正確性を検証、ユーザ登録や編集・削除
  # パスワーリセット、ログイン情報を保存、バリデーション

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # 自分がフォローする側（与フォロー）の関係性
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローされる側（被フォロー）の関係性
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :followed_relationships, source: :followed
  #被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :follower_relationships

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def follow(other_user)
    self.followed_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.followed_relationships.find_by(followed_id: other_user.id).destroy
  end
  def self.search(word,search)
    if search == "perfect"
      @user = User.where("name LIKE?","#{word}")
    elsif search == "forward"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?","%#{word}")
    elss
      @user = User.where("name LIKE?","%#{word}%")
    end
  end
end
