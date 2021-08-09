class Api::V1::BreweriesController < ApplicationController
  def index
    @breweries = BreweriesFacade.breweries(params[:location],params[:quantity])
    json_response(BreweriesSerializer.new(@breweries))
  end
end
