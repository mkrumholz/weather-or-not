require 'rails_helper'

RSpec.describe BreweriesFacade do
  describe '::breweries' do
    it 'returns a brewery object with forecast, location, and breweries info', :vcr do
      breweries = BreweriesFacade.breweries('denver,co', 5)

      expect(breweries).to be_a Breweries

      expect(breweries.id).to eq nil
      expect(breweries.destination).to eq 'denver,co'

      expect(breweries.forecast).to be_a Hash
      expect(breweries.forecast[:summary]).to be_a String
      expect(breweries.forecast[:temperature]).to match(/\d{1,3} F/)

      expect(breweries.breweries).to be_an Array

      first_brewery = breweries.breweries.first
      expect(first_brewery).to be_a Hash
      expect(first_brewery[:id]).to be_an Integer
      expect(first_brewery[:name]).to be_a String
      expect(first_brewery[:brewery_type]).to be_a String

      expect(first_brewery).not_to have_key :phone
      expect(first_brewery).not_to have_key :website_url
      expect(first_brewery).not_to have_key :obdb_id
    end
  end
end
