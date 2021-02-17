class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries
  has_many :notifications, dependent: :destroy

  def create_notification_message!(current_user, message_id)
    temp_ids = Entry.select(:user_id).where(room_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      notification = current_user.active_notifications.new(
        room_id: id,
        message_id: message_id,
        visited_id: temp_id['user_id'],
        action: 'message'
      )
      notification.save
    end
  end
end
