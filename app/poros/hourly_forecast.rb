class HourlyForecast
  def initialize(hourly_details, timezone_offset)
    @time = hourly_details[:dt]
    @timezone_offset = timezone_offset
    @temperature = hourly_details[:temp]
    @weather = hourly_details[:weather].first
  end

  def details
    {
      time: Time.at(@time + @timezone_offset).strftime('%H:%M:%S'),
      temperature: @temperature,
      conditions: @weather[:description],
      icon: @weather[:icon]
    }
  end
end
