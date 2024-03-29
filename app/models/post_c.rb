class PostC < ApplicationRecord
  #投稿時期が早いものから順に表示
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true
  validates :region, presence: true
  validates :datetime, presence: true
  validates :price, presence: true
  validates :payment, presence: true
  validates :content, presence: true

  belongs_to :user
  
  has_many :favorite_cs, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  mount_uploader :image, ImageUploader

  def create_notification_favorite_c!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_c_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        post_c_id: id,
        visited_id: user_id,
        action: 'favorite'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
