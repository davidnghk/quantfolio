json.array!(@holdings) do |holding|
  json.extract! holding, :id, :portfolio_id, :vehicle_id, :units, :unit_cost, :target_price, :target_weighting
  json.url holding_url(holding, format: :json)
end
