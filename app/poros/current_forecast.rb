class CurrentForecast
  def initialize(current_details, timezone_offset)
    @datetime = current_details[:dt]
    @timezone_offset = timezone_offset
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
      datetime: Time.at(@datetime + @timezone_offset).to_s,
      sunrise: Time.at(@sunrise + @timezone_offset).to_s,
      sunset: Time.at(@sunset + @timezone_offset).to_s,
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
