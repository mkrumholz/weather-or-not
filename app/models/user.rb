class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  
  has_secure_password
  has_one :api_key
end
