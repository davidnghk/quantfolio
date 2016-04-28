json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id, :ticker, :name, :currency, :last_price
  json.url vehicle_url(vehicle, format: :json)
end
