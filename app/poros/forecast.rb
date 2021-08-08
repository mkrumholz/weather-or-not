class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather
  
  def initialize(weather_details)
    @current_weather = weather_details[:current_weather]
    @daily_weather = weather_details[:daily_weather]
    @hourly_weather = weather_details[:hourly_weather]
  end
end
