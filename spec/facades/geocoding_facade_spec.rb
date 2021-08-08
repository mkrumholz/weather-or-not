require 'rails_helper'

RSpec.describe GeocodingFacade do
  describe '::coordinates' do
    it 'gets coordinates from GeocodingService request', :vcr do
      coordinates = GeocodingFacade.coordinates('denver,co')

      expect(coordinates).to be_a Hash
      expect(coordinates.length).to eq 2
      expect(coordinates[:lat]).to eq 39.738453
      expect(coordinates[:lon]).to eq -104.984853
    end
  end
end
