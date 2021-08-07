require 'rails_helper'

RSpec.describe CurrentForecast do
  describe '#details' do
    it 'returns a hash of object details for a current forecast' do
      timezone_offset = -21600
      current = {:dt=>1628376892,
        :sunrise=>1628337889,
        :sunset=>1628388393,
        :temp=>300.66,
        :feels_like=>299.68,
        :pressure=>1017,
        :humidity=>24,
        :dew_point=>278.31,
        :uvi=>2.67,
        :clouds=>42,
        :visibility=>10000,
        :wind_speed=>0.89,
        :wind_deg=>318,
        :wind_gust=>2.24,
        :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}]}

      current_weather = CurrentForecast.new(current, timezone_offset)

      actual = current_weather.details
      expect(actual).to be_a Hash
      expect(actual.length).to eq 10
      expect(actual[:datetime]).to be_a String
      expect(actual[:sunrise]).to be_a String
      expect(actual[:sunset]).to be_a String
      expect(actual[:temperature]).to be_a Float
      expect(actual[:feels_like]).to be_a Float
      expect(actual[:humidity]).to be_a Numeric
      expect(actual[:uvi]).to be_a Numeric
      expect(actual[:visibility]).to be_a Numeric
      expect(actual[:conditions]).to be_a String
      expect(actual[:icon]).to be_a String
      expect(actual).not_to have_key :dew_point
      expect(actual).not_to have_key :clouds
      expect(actual).not_to have_key :wind_speed
    end
  end
end
