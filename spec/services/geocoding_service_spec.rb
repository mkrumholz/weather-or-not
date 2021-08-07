require 'rails_helper'

RSpec.describe GeocodingService do
  describe '::get_coordinates' do
    it 'returns latitude and longitude for the given city and state' do
      response = GeocodingService.get_coordinates('denver,co')

      expect(response).to have_http_status 200
      
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:info]).to be_a Hash
      expect(body[:options]).to be_a Hash
      expect(body[:results]).to be_an Array

      results = body[:results].first
      expect(results[:provided_location]).to eq 'denver,co' 
      expect(results[:locations]).to be_an Array
      expect(results[:locations][:latLng]).to be_a Hash
      expect(results[:locations][:latLng][:lat]).to eq 39.738453
      expect(results[:locations][:latLng][:lng]).to eq -104.984853
      expect(results[:locations][:mapUrl]).to eq "http://www.mapquestapi.com/staticmap/v5/map?key=BHz3viihx4lluXWAkz8ykAr2gassWjqQ&type=map&size=225,160&locations=39.738453,-104.984853|marker-sm-50318A-1&scalebar=true&zoom=12&rand=793049141"
    end
  end
end
