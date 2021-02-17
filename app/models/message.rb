class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # has_many :notifications, dependent: :destroy

  def template
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
  end
end
