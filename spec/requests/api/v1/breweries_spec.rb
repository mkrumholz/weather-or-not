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

      destination = breweries[:attributes][:destination]
      expect(destination).to eq 'denver,co'

      forecast = breweries[:attributes][:forecast]
      expect(forecast).to be_a Hash
      expect(forecast[:summary]).to be_a String
      expect(forecast[:temperature]).to be_a String

      brewery_list = breweries[:attributes][:breweries]
      expect(brewery_list).to be_an Array

      expect(brewery_list.first).to be_a Hash
      expect(brewery_list.first[:id]).to be_an Integer
      expect(brewery_list.first[:name]).to be_a String
      expect(brewery_list.first[:brewery_type]).to be_a String
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
