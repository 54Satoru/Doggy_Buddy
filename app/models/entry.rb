class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # validates :room_id, uniquenes: { scope: :user_id }
end
