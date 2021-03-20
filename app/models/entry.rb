class Entry < ApplicationRecord
  validates_uniqueness_of :room_id, scope: :user_id

  belongs_to :user
  belongs_to :room
end
