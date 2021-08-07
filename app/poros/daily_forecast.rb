class DailyForecast
  def initialize(daily_details, timezone_offset)
    @date = daily_details[:dt]
    @timezone_offset = timezone_offset
    @sunrise = daily_details[:sunrise]
    @sunset = daily_details[:sunset]
    @max_temp = daily_details[:temp][:max]
    @min_temp = daily_details[:temp][:min]
    @weather = daily_details[:weather].first
  end

  def details
    {
      date: Time.at(@date + @timezone_offset).strftime('%Y-%m-%d'),
      sunrise: Time.at(@sunrise + @timezone_offset).to_s,
      sunset: Time.at(@sunset + @timezone_offset).to_s,
      max_temp: @max_temp,
      min_temp: @min_temp,
      conditions: @weather[:description],
      icon: @weather[:icon]
    }
  end
end
