class Message < ApplicationRecord
  validates :content, presence: true, unless: :image?
  
  belongs_to :user
  belongs_to :room

  # has_many :notifications, dependent: :destroy

  mount_uploader :image, ImageUploader
  
  def template
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
  end
end
