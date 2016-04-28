json.array!(@portfolios) do |portfolio|
  json.extract! portfolio, :id, :code, :name, :capital, :cash, :start_date, :end_date, :user_id
  json.url portfolio_url(portfolio, format: :json)
end
