class BreweriesFacade
  def self.breweries(location, quantity)
    coordinates = GeocodingFacade.coordinates(location)
    local_details = {
      location: location,
      forecast: forecast_basics(coordinates),
      breweries: brewery_list(coordinates, quantity)
    }
    Breweries.new(local_details)
  end

  def self.brewery_list(coords, quantity)
    breweries = OpenBreweryService.get_breweries(coords[:lat], coords[:lon], quantity)
    breweries.map do |brewery|
      {
        id: brewery[:id],
        name: brewery[:name],
        brewery_type: brewery[:brewery_type]
      }
    end
  end

  def self.forecast_basics(coordinates)
    forecast = OpenWeatherService.get_forecast(coordinates[:lat], coordinates[:lon])
    {
      summary: forecast[:current][:weather].first[:description],
      temperature: "#{forecast[:current][:temp].round} F"
    }
  end
end
