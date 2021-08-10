class ApiKey < ApplicationRecord
  validates :token, uniqueness: true, presence: true

  belongs_to :user

  def self.generate_new
    SecureRandom.base64
  end
end
