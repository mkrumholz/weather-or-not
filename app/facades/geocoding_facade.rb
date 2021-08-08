class GeocodingFacade
  def self.coordinates(location)
    response = GeocodingService.get_coordinates(location)
    lat_lng = response[:results].first[:locations].first[:latLng]
    {
      lat: lat_lng[:lat],
      lon: lat_lng[:lng]
    }
  end
end
