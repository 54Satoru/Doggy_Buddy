class PostC < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  has_many :favorite_cs, dependent: :destroy
  has_many :favorite_sitters, dependent: :destroy

  #投稿時期が早いものから順に表示
  default_scope -> { order(created_at: :desc) }
end
