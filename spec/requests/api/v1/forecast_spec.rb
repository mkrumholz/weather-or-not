require 'rails_helper'

RSpec.describe 'forecast' do
  describe 'GET /forecast' do
    it 'returns the weather for a provided city and state' do
      get '/api/v1/forecast', params: {location: 'denver,co'}

      expect(response).to have_http_status 200

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a Hash
      expect(response_body[:data]).to be_a Hash

      forecast = response_body[:data]
      expect(forecast[:id]).to eq nil
      expect(forecast[:type]).to eq 'forecast'
      expect(forecast[:attributes]).to be_a Hash

      current_weather = forecast[:attributes][:current_weather]
      daily_weather = forecast[:attributes][:daily_weather]
      hourly_weather = forecast[:attributes][:hourly_weather]

      expect(current_weather).to be_a Hash
      expect(current_weather[:datetime]).to be_a String
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather[:humidity]).to be_a Float
      expect(current_weather[:uvi]).to be_a Float
      expect(current_weather[:visibility]).to be_a Float
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather[:icon]).to be_a String

      expect(daily_weather).to be_an Array
      expect(daily_weather.first[:date]).to be_a String
      expect(daily_weather.first[:sunrise]).to be_a String
      expect(daily_weather.first[:sunset]).to be_a String
      expect(daily_weather.first[:max_temp]).to be_a Float
      expect(daily_weather.first[:min_temp]).to be_a Float
      expect(daily_weather.first[:conditions]).to be_a String
      expect(daily_weather.first[:icon]).to be_a String

      expect(hourly_weather).to be_an Array
      expect(hourly_weather.first[:time]).to be_a String
      expect(hourly_weather.first[:temperature]).to be_a Float
      expect(hourly_weather.first[:conditions]).to be_a String
      expect(hourly_weather.first[:icon]).to be_a String
    end

    it 'returns an error message and 404 error code if the city or state are not provided' do
      get '/api/v1/forecast', params: {location: 'denver'}

      expect(response).to have_http_status 404

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to match(/Location not found/)
    end

    it 'returns an error message and 422 error code if no parameters are provided' do
      get '/api/v1/forecast'

      expect(response).to have_http_status 422

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to match(/Bad request/)
    end
  end
end
