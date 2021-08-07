class GeocodingFacade
  def self.coordinates(location)
    response = GeocodingService.get_coordinates(location)
    latLng = response[:results].first[:locations].first[:latLng]
    {
      lat: latLng[:lat],
      lon: latLng[:lng]
    }
  end
end
