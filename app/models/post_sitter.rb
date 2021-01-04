class PostSitter < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  #投稿時期が早いものから順に表示
  default_scope -> { order(created_at: :desc) }
end
