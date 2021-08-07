class OpenWeatherFacade
  def self.forecast(location)
    coordinates = GeocodingFacade.coordinates(location)
    forecast = OpenWeatherService.get_forecast(coordinates[:lat], coordinates[:lon])
    require 'pry'; binding.pry
    current = CurrentForecast.new(forecast[:current])
    daily = forecast[:daily].first(5).map do |day|
      DailyForecast.new(day).details
    end
    hourly = forecast[:hourly].first(8).map do |hour|
      daily << HourlyForecast.new(hour).details
    end
    {
      current_weather: current,
      daily_weather: daily,
      hourly_weather: hourly,
    }
  end
end
