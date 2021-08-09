require 'rails_helper'

RSpec.describe 'breweries' do
  describe 'GET /breweries' do
    it 'returns a list of (quantity) breweries along with forecast info', :vcr do
      get '/api/v1/breweries', params: {location: 'denver,co', quantity: 5}

      expect(response).to have_http_status 200

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a Hash
      expect(response_body[:data]).to be_a Hash

      breweries = response_body[:data]
      expect(breweries[:id]).to eq nil
      expect(breweries[:type]).to eq 'breweries'
      expect(breweries[:attributes]).to be_a Hash

      expect(breweries[:attributes][:destination]).to eq 'denver,co'
      expect(breweries[:attributes][:forecast]).to be_a Hash
      expect(breweries[:attributes][:forecast]).to have_key :summary
      expect(breweries[:attributes][:forecast]).to have_key :temperature

      expect(breweries[:attributes][:breweries]).to be_an Array
      expect(breweries[:attributes][:breweries].first).to be_a Hash
      expect(breweries[:attributes][:breweries].first).to have_key :id
      expect(breweries[:attributes][:breweries].first[:id]).to be_an Integer

      expect(breweries[:attributes][:breweries].first).to have_key :name
      expect(breweries[:attributes][:breweries].first[:name]).to be_a String

      expect(breweries[:attributes][:breweries].first).to have_key :brewery_type
      expect(breweries[:attributes][:breweries].first[:brewery_type]).to be_a String
    end
  end
end
