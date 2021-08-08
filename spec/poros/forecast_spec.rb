require 'rails_helper'

RSpec.describe Forecast do
  describe '::new' do
    it 'contains all forecast details for current, hourly, and daily forecasts' do
      timezone = 'America/Chicago'
      current = {:datetime=>"2021-08-07 18:57:09 -0600",
        :sunrise=>"2021-08-07 06:04:49 -0600",
        :sunset=>"2021-08-07 20:06:33 -0600",
        :temperature=>298.54,
        :feels_like=>297.92,
        :humidity=>30,
        :uvi=>0.26,
        :visibility=>10000,
        :conditions=>"clear sky",
        :icon=>"01d"}
      daily = {:date=>"2021-08-07",
        :sunrise=>"2021-08-07 06:04:49 -0600",
        :sunset=>"2021-08-07 20:06:33 -0600",
        :max_temp=>303.03,
        :min_temp=>293.41,
        :conditions=>"clear sky",
        :icon=>"01d"}
      daily_list = []
      5.times {|day| daily_list << daily}
      hourly = {:time=>"18:00:00", :temperature=>299.47, :conditions=>"clear sky", :icon=>"01d"}
      hourly_list = []
      8.times {|day| hourly_list << hourly}
      forecast_details = {
        current_weather: current,
        daily_weather: daily_list,
        hourly_weather: hourly_list
      }
      
      forecast = Forecast.new(forecast_details)
      expect(forecast).to be_a Forecast
      expect(forecast.current_weather.length).to eq 10
      expect(forecast.daily_weather.length).to eq 5
      expect(forecast.daily_weather.first.length).to eq 7
      expect(forecast.hourly_weather.length).to eq 8
      expect(forecast.hourly_weather.first.length).to eq 4
    end
  end
end
