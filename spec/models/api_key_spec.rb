require 'rails_helper'

RSpec.describe ApiKey do
  describe 'relationships' do
    it {should belong_to :user}
  end

  describe 'validations' do
    it {should validate_presence_of :token}
    it {should validate_uniqueness_of :token}
  end

  describe 'class methods' do
    describe '::generate_new' do 
      it 'generates a new api key' do
        key = ApiKey.generate_new
        expect(key).to be_a String
      end
    end
  end
end
