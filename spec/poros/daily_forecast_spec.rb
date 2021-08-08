require 'rails_helper'

RSpec.describe DailyForecast do
  describe '#details' do
    it 'returns a hash of object details for a daily forecast' do
      timezone = 'America/Chicago'
      daily = {:dt=>1628362800,
        :sunrise=>1628337889,
        :sunset=>1628388393,
        :moonrise=>1628333400,
        :moonset=>1628388300,
        :moon_phase=>0.97,
        :temp=>{:day=>302.05, :min=>293.41, :max=>302.28, :night=>297.48, :eve=>301.54, :morn=>294.05},
        :feels_like=>{:day=>300.51, :night=>296.7, :eve=>300.19, :morn=>293.21},
        :pressure=>1007,
        :humidity=>19,
        :dew_point=>276.14,
        :wind_speed=>7.74,
        :wind_deg=>320,
        :wind_gust=>9.33,
        :weather=>[{:id=>801, :main=>"Clouds", :description=>"few clouds", :icon=>"02d"}],
        :clouds=>16,
        :pop=>0.16,
        :uvi=>9.04}

      daily_weather = DailyForecast.new(daily, timezone)

      actual = daily_weather.details
      expect(actual).to be_a Hash
      expect(actual.length).to eq 7
      expect(actual[:date]).to be_a String
      expect(actual[:sunrise]).to be_a String
      expect(actual[:sunset]).to be_a String
      expect(actual[:max_temp]).to be_a Float
      expect(actual[:min_temp]).to be_a Float
      expect(actual[:conditions]).to be_a String
      expect(actual[:icon]).to be_a String
    end
  end
end
