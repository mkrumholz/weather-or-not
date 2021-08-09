class Api::V1::BreweriesController < ApplicationController
  def index
    return json_response({ error: 'Bad request' }, :bad_request) unless params_valid?(params)

    @breweries = BreweriesFacade.breweries(params[:location], params[:quantity])
    json_response(BreweriesSerializer.new(@breweries))
  end

  private

  def params_valid?(params)
    params[:location].present? && params[:quantity].present? && params[:quantity].to_i > 0
  end
end
