class Breweries
  attr_reader :id, :destination, :forecast, :breweries

  def initialize(local_details)
    @id = nil
    @destination = local_details[:location]
    @forecast = local_details[:forecast]
    @breweries = local_details[:breweries]
  end
end
