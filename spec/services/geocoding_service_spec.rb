require 'rails_helper'

RSpec.describe GeocodingService do
  describe '::get_coordinates' do
    before do
      VCR.turn_off!
      WebMock.allow_net_connect!
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!
    end

    it 'returns latitude and longitude for the given city and state' do
      response = GeocodingService.get_coordinates('denver,co')

      expect(response).to be_a Hash
      expect(response[:info]).to be_a Hash
      expect(response[:options]).to be_a Hash
      expect(response[:results]).to be_an Array

      results = response[:results].first
      expect(results[:providedLocation][:location]).to eq 'denver,co' 
      expect(results[:locations]).to be_an Array
      expect(results[:locations].first[:latLng]).to be_a Hash
      expect(results[:locations].first[:latLng][:lat]).to eq 39.738453
      expect(results[:locations].first[:latLng][:lng]).to eq -104.984853
    end
  end
end
