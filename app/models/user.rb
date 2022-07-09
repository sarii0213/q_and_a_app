class User < ApplicationRecord
  has_secure_password
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one_attached :image
end
