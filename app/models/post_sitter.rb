class PostSitter < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  has_many :favorite_sitters, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  #投稿時期が早いものから順に表示
  default_scope -> { order(created_at: :desc) }

  
  def create_notification_favorite_sitter!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_sitter_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        post_sitter_id: id,
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
