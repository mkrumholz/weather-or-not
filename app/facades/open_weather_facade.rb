class OpenWeatherFacade
  def self.forecast(location)
    coordinates = GeocodingFacade.coordinates(location)
    forecast = OpenWeatherService.get_forecast(coordinates[:lat], coordinates[:lon])
    tz_offset = forecast[:timezone_offset]
    {
      current_weather: current_details(forecast[:current], tz_offset),
      daily_weather: daily_details(forecast[:daily], tz_offset),
      hourly_weather: hourly_details(forecast[:hourly], tz_offset)
    }
  end

  def self.current_details(current_forecast, timezone_offset)
    CurrentForecast.new(current_forecast, timezone_offset).details
  end

  def self.daily_details(daily_forecasts, timezone_offset)
    daily_forecasts.first(5).map do |day|
      DailyForecast.new(day, timezone_offset).details
    end
  end

  def self.hourly_details(hourly_forecasts, timezone_offset)
    hourly_forecasts.first(8).map do |hour|
      HourlyForecast.new(hour, timezone_offset).details
    end
  end
end
