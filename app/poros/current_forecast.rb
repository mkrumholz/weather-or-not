class CurrentForecast
  def initialize(current_details, timezone)
    @datetime = current_details[:dt]
    @timezone = timezone
    @sunrise = current_details[:sunrise]
    @sunset = current_details[:sunset]
    @temperature = current_details[:temp]
    @feels_like = current_details[:feels_like]
    @humidity = current_details[:humidity]
    @uvi = current_details[:uvi]
    @visibility = current_details[:visibility]
    @weather = current_details[:weather].first
  end

  def details
    {
      datetime: Time.at(@datetime).in_time_zone(@timezone).to_s,
      sunrise: Time.at(@sunrise).in_time_zone(@timezone).to_s,
      sunset: Time.at(@sunset).in_time_zone(@timezone).to_s,
      temperature: @temperature,
      feels_like: @feels_like,
      humidity: @humidity,
      uvi: @uvi,
      visibility: @visibility,
      conditions: @weather[:description],
      icon: @weather[:icon]
    }
  end
end
