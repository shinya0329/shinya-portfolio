class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # deviseで使用する機能の記述
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy 
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :profile_image
  
  validates :name, presence: true
  validates :profile_image, content_type: ['image/png', 'image/jpeg'], size: { between: 1.kilobyte..1.megabytes , message: '画像容量が大きすぎます。1MB以下にしてください。' }
end