class OpenWeatherService
  def self.get_forecast(lat, lon)
    response = Faraday.get('https://api.openweathermap.org/data/2.5/onecall') do |req|
      req.params['appid'] = ENV['open_weather_key']
      req.params['lat'] = lat
      req.params['lon'] = lon
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
