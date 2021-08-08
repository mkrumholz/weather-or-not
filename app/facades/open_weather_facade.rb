class OpenWeatherFacade
  def self.forecast(location)
    coordinates = GeocodingFacade.coordinates(location)
    forecast = OpenWeatherService.get_forecast(coordinates[:lat], coordinates[:lon])
    timezone_offset = forecast[:timezone_offset]
    current = CurrentForecast.new(forecast[:current], timezone_offset).details
    daily = forecast[:daily].first(5).map do |day|
      DailyForecast.new(day, timezone_offset).details
    end
    hourly = forecast[:hourly].first(8).map do |hour|
      HourlyForecast.new(hour, timezone_offset).details
    end
    {
      current_weather: current,
      daily_weather: daily,
      hourly_weather: hourly
    }
  end
end
