class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: { require: true }

  has_one :api_key
  has_secure_password
end
