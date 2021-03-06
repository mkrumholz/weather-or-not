class GeocodingService
  def self.get_coordinates(location)
    response = Faraday.get('http://www.mapquestapi.com/geocoding/v1/address') do |req|
      req.params['key'] = ENV['geocoding_key']
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
