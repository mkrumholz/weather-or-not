require 'rails_helper'

RSpec.describe OpenWeatherService do
  describe '::get_forecast' do
    before do
      VCR.turn_off!
      WebMock.allow_net_connect!
    end
    
    after do
      VCR.turn_on!
      WebMock.disable_net_connect!
    end

    it 'returns the current, daily, and hourly forecast for the location provided' do
      response = OpenWeatherService.get_forecast(39.738453,-104.984853)

      expect(response).to be_a Hash
      expect(response[:lat]).to eq 39.7385
      expect(response[:lon]).to eq -104.9849
      expect(response[:timezone]).to eq 'America/Denver'
      expect(response[:timezone_offset]).to eq -21600

      current = response[:current]
      expect(current).to be_a Hash
      expect(current[:dt]).to be_an Integer
      expect(current[:sunrise]).to be_an Integer
      expect(current[:sunset]).to be_an Integer
      expect(current[:feels_like]).to be_an Numeric
      expect(current[:pressure]).to be_a Numeric
      expect(current[:humidity]).to be_an Numeric
      expect(current[:dew_point]).to be_a Numeric
      expect(current[:uvi]).to be_a Numeric
      expect(current[:clouds]).to be_a Numeric
      expect(current[:visibility]).to be_a Numeric
      expect(current[:wind_speed]).to be_a Numeric
      expect(current[:weather]).to be_an Array
      expect(current[:weather].first[:main]).to be_a String
      expect(current[:weather].first[:description]).to be_a String
      expect(current[:weather].first[:icon]).to be_a String

      hourly = response[:hourly]
      expect(hourly).to be_an Array
      expect(hourly.first[:dt]).to be_an Integer
      expect(hourly.first[:temp]).to be_a Numeric
      expect(hourly.first[:feels_like]).to be_a Numeric
      expect(hourly.first[:pressure]).to be_a Numeric
      expect(hourly.first[:weather].first[:main]).to be_a String
      expect(hourly.first[:weather].first[:description]).to be_a String
      expect(hourly.first[:weather].first[:icon]).to be_a String

      daily = response[:daily]
      expect(daily).to be_an Array
      expect(daily.first[:dt]).to be_an Integer
      expect(daily.first[:sunrise]).to be_a Integer
      expect(daily.first[:sunset]).to be_a Integer
      expect(daily.first[:temp]).to be_a Hash
      expect(daily.first[:temp][:min]).to be_a Numeric
      expect(daily.first[:temp][:max]).to be_a Numeric
      expect(daily.first[:pressure]).to be_a Numeric
      expect(daily.first[:humidity]).to be_a Numeric
      expect(daily.first[:weather].first[:main]).to be_a String
      expect(daily.first[:weather].first[:description]).to be_a String
      expect(daily.first[:weather].first[:icon]).to be_a String
    end
  end
end
