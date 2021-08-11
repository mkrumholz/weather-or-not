require 'rails_helper'

RSpec.describe HourlyForecast do
  describe '#details' do
    it 'returns a hash of object details for a hourly forecast' do
      timezone = 'America/Chicago'
      hourly = {:dt=>1628377200,
      :temp=>300.45,
      :feels_like=>299.65,
      :pressure=>1005,
      :humidity=>27,
      :dew_point=>279.83,
      :uvi=>2.67,
      :clouds=>42,
      :visibility=>10000,
      :wind_speed=>7.74,
      :wind_deg=>320,
      :wind_gust=>8.9,
      :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
      :pop=>0.04}

      hourly_weather = HourlyForecast.new(hourly, timezone)

      actual = hourly_weather.details
      expect(actual).to be_a Hash
      expect(actual.length).to eq 4
      expect(actual[:time]).to be_a String
      expect(actual[:time]).to match(/\d{2}:\d{2}:\d{2}/)

      expect(actual[:temperature]).to be_a Float
      expect(actual[:conditions]).to be_a String
      expect(actual[:icon]).to be_a String
    end
  end
end
