class BreweriesFacade
  def self.breweries(location, quantity)
    coords = GeocodingFacade.coordinates(location)
    forecast = OpenWeatherService.get_forecast(coords[:lat], coords[:lon])
    breweries = OpenBreweryService.get_breweries(coords[:lat],coords[:lon],quantity)
    forecast_details = {
      summary: forecast[:current][:weather].first[:description],
      temperature: "#{forecast[:current][:temp].round.to_s} F"
    }
    brewery_list = breweries.map do |brewery|
      {
        id: brewery[:id],
        name: brewery[:name],
        brewery_type: brewery[:brewery_type]
      }
    end
    local_details = {
      location: location,
      forecast: forecast_details,
      breweries: brewery_list
    }
    # require 'pry'; binding.pry
    Breweries.new(local_details)
  end
end
