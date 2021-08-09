require 'rails_helper'

RSpec.describe 'Breweries Request' do
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

    it 'returns an error message and 400 error code if the location param is not valid', :vcr do
      get '/api/v1/breweries', params: {location: ''}

      expect(response).to have_http_status 400

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({error: 'Bad request'})
    end

    it 'returns an error message and 400 error code if the quantity param is not a valid integer', :vcr do
      get '/api/v1/breweries', params: {location: 'denver,co', quantity: -10}

      expect(response).to have_http_status 400

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({error: 'Bad request'})
    end

    it 'returns an error message and 400 error code if the quantity param is not an integer', :vcr do
      get '/api/v1/breweries', params: {location: 'denver,co', quantity: 'string'}

      expect(response).to have_http_status 400

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({error: 'Bad request'})
    end

    it 'returns an error message and 400 error code if no parameters are provided', :vcr do
      get '/api/v1/breweries'

      expect(response).to have_http_status 400

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq({error: 'Bad request'})
    end
  end
end
