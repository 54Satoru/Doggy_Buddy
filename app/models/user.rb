class User < ApplicationRecord
  #devise設定
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :username, presence: true, length: { maximum: 15 }
  
  #image読み込み
  mount_uploader :image, ImageUploader
  
  #投稿
  has_many :post_cs, dependent: :destroy
  has_many :post_sitters, dependent: :destroy

  #レビュー
  has_many :reviews, dependent: :destroy

  #お気に入り
  has_many :favorite_cs, dependent: :destroy
  has_many :favorite_sitters, dependent: :destroy

  #メッセージ
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries, foreign_key: :user_id

  #通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  #フォロー
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  #ゲストログイン
  def self .guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  #ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  #ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  #フォロー時の通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
