class PostC < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
end
