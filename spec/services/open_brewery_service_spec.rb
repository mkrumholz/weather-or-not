require 'rails_helper'

RSpec.describe OpenBreweryService do
  describe '::get_breweries' do
    it 'returns a list of breweries for given coordinates', :vcr do
      response = OpenBreweryService.get_breweries(39.738453,-104.984853,5)

      expect(response).to be_an Array
      expect(response.length).to eq 5

      response.each do |brewery|
        expect(brewery).to be_a Hash
        expect(brewery[:id]).to be_an Integer
        expect(brewery[:name]).to be_a String
        expect(brewery[:brewery_type]).to be_a String
      end
    end

    it 'returns 50 breweries maximum if quantity exceeds 50', :vcr do
      response = OpenBreweryService.get_breweries(39.738453,-104.984853,57)

      expect(response).to be_an Array
      expect(response.length).to eq 50

      response.each do |brewery|
        expect(brewery).to be_a Hash
        expect(brewery[:id]).to be_an Integer
        expect(brewery[:name]).to be_a String
        expect(brewery[:brewery_type]).to be_a String
      end
    end
  end
end
