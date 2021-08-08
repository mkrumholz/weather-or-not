class HourlyForecast
  def initialize(hourly_details, timezone)
    @time = hourly_details[:dt]
    @timezone = timezone
    @temperature = hourly_details[:temp]
    @weather = hourly_details[:weather].first
  end

  def details
    {
      time: Time.at(@time).in_time_zone(@timezone).strftime('%H:%M:%S'),
      temperature: @temperature,
      conditions: @weather[:description],
      icon: @weather[:icon]
    }
  end
end
