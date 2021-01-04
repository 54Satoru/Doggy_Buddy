class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #devise設定
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  #image読み込み
  mount_uploader :image, ImageUploader
  
  has_many :post_cs, dependent: :destroy
  has_many :post_sitters, dependent: :destroy
end
