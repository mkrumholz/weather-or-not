class ApiKey < ApplicationRecord
  validates :token, uniqueness: true, presence: true

  belongs_to :user
end
