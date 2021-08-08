class OpenWeatherFacade
  def self.forecast(location)
    coordinates = GeocodingFacade.coordinates(location)
    forecast = OpenWeatherService.get_forecast(coordinates[:lat], coordinates[:lon])
    weather_details = {
      current_weather: current_details(forecast[:current], forecast[:timezone]),
      daily_weather: daily_details(forecast[:daily], forecast[:timezone]),
      hourly_weather: hourly_details(forecast[:hourly], forecast[:timezone])
    }
    Forecast.new(weather_details)
  end

  def self.current_details(current_forecast, timezone)
    CurrentForecast.new(current_forecast, timezone).details
  end

  def self.daily_details(daily_forecasts, timezone)
    daily_forecasts.first(5).map do |day|
      DailyForecast.new(day, timezone).details
    end
  end

  def self.hourly_details(hourly_forecasts, timezone)
    hourly_forecasts.first(8).map do |hour|
      HourlyForecast.new(hour, timezone).details
    end
  end
end
