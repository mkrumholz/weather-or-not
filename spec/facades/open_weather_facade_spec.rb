require 'rails_helper'

RSpec.describe OpenWeatherFacade do
  describe '::forecast' do
    before do
      VCR.turn_off!
      WebMock.allow_net_connect!
    end
    
    after do
      VCR.turn_on!
      WebMock.disable_net_connect!
    end
    it 'returns the complete forecast for the provided location' do  
      forecast = OpenWeatherFacade.forecast('denver,co')

      expect(forecast).to be_a Hash

      current_weather = forecast[:current_weather]
      expect(current_weather).to be_a Hash
      expect(current_weather.length).to eq 10
      expect(current_weather[:datetime]).to be_a String
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather[:humidity]).to be_a Numeric
      expect(current_weather[:uvi]).to be_a Numeric
      expect(current_weather[:visibility]).to be_a Numeric
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather[:icon]).to be_a String
      expect(current_weather).not_to have_key :dew_point
      expect(current_weather).not_to have_key :clouds
      expect(current_weather).not_to have_key :wind_speed

      daily_weather = forecast[:daily_weather]
      expect(daily_weather).to be_an Array
      expect(daily_weather.length).to eq 5
      expect(daily_weather.first.length).to eq 7
      expect(daily_weather.first[:date]).to be_a String
      expect(daily_weather.first[:sunrise]).to be_a String
      expect(daily_weather.first[:sunset]).to be_a String
      expect(daily_weather.first[:max_temp]).to be_a Float
      expect(daily_weather.first[:min_temp]).to be_a Float
      expect(daily_weather.first[:conditions]).to be_a String
      expect(daily_weather.first[:icon]).to be_a String
      expect(daily_weather.first).not_to have_key :pressure
      expect(daily_weather.first).not_to have_key :humidity


      hourly_weather = forecast[:hourly_weather]
      expect(hourly_weather).to be_an Array
      expect(hourly_weather.length).to eq 8
      expect(hourly_weather.first.length).to eq 4
      expect(hourly_weather.first[:time]).to be_a String
      expect(hourly_weather.first[:temperature]).to be_a Float
      expect(hourly_weather.first[:conditions]).to be_a String
      expect(hourly_weather.first[:icon]).to be_a String
      expect(hourly_weather.first).not_to have_key :pressure
      expect(hourly_weather.first).not_to have_key :feels_like
    end
  end
end
