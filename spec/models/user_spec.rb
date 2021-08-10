require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it {should have_one :api_key}
  end

  describe 'validations' do
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
    it {should validate_confirmation_of(:password).on(:create)}
    it {should validate_uniqueness_of :email}
  end
end
