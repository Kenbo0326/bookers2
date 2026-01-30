class User < ApplicationRecord
  has_secure_password 
  has_one_attached :profile_image 
  has_many :books, dependent: :destroy
end
