class BreweriesFacade
  def self.breweries(location, quantity)
    coords = GeocodingFacade.coordinates(location)
    forecast = OpenWeatherService.get_forecast(coords[:lat], coords[:lon])
    breweries = OpenBreweryService.get_breweries(coords[:lat],coords[:lon],quantity)
    Breweries.new(location,forecast,breweries)
  end
end
