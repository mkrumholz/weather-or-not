require 'rails_helper'

RSpec.describe Breweries do
  describe '::new' do
    it 'contains location, forecast, and list of breweries' do
      location = 'denver,co'
      forecast = {
        summary: "Cloudy with a chance of meatballs",
        temperature: "83 F"
      }
      brewary_list = [
        {:id=>8962, :name=>"Black Beak Brewing", :brewery_type=>"planning"},
        {:id=>8245, :name=>"Aero Craft Brewing", :brewery_type=>"planning"},
        {:id=>13467, :name=>"Pints Pub Brewery and Freehouse", :brewery_type=>"brewpub"},
        {:id=>11093, :name=>"Grandma's House", :brewery_type=>"micro"},
        {:id=>8598, :name=>"Banded Oak Brewing Company", :brewery_type=>"brewpub"}
      ]
      local_details = {
        location: location,
        forecast: forecast,
        breweries: brewary_list
      }

      breweries = Breweries.new(local_details)
      expect(breweries.id).to eq nil
      expect(breweries.destination).to eq location
      expect(breweries.forecast).to eq forecast
      expect(breweries.breweries).to eq brewary_list
    end
  end
end
