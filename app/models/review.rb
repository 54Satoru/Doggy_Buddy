class Review < ApplicationRecord
  validates :content, presence: true
  validates :rate, presence: true
  validates :position, presence: true

  belongs_to :user
  has_many :notifications, dependent: :destroy

  def create_notification_review!(current_user, user)
    notification = current_user.active_notifications.new(
      visited_id: user.id,
      action: 'review'
    )
    notification.save if notification.valid?
  end
end
