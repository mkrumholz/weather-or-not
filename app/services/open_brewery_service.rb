class OpenBreweryService
  def self.get_breweries(lat, lon, quantity)
    response = Faraday.get('https://api.openbrewerydb.org/breweries') do |req|
      req.params['per_page'] = quantity
      req.params['by_dist'] = "#{lat},#{lon}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
