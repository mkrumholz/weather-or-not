class Api::V1::ForecastsController < ApplicationController
  def show
    return json_response({ error: 'Bad request' }, :bad_request) if params[:location].blank?
    @forecast = OpenWeatherFacade.forecast(params[:location])
    json_response(ForecastSerializer.new(@forecast))
  end
end
