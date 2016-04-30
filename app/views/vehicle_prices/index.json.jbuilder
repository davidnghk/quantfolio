json.array!(@vehicle_prices) do |vehicle_price|
  json.extract! vehicle_price, :id, :vehicle_id, :trade_date, :open, :volume, :high, :low, :close, :adj_close
  json.url vehicle_price_url(vehicle_price, format: :json)
end
