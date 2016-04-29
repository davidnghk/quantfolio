class Vehicle < ActiveRecord::Base
  has_many :holdings
  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end 
  
  def self.new_from_lookup(ticker_symbol)
    looked_up_vehicle = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_vehicle.name
    
    new_vehicle = new(ticker: looked_up_vehicle.symbol, name: looked_up_vehicle.name,
                      last_price: looked_up_vehicle.last_trade_price_only)
    new_vehicle
  end
  
  def price 
    last_trade_price = StockQuote::Stock.quote(ticker).last_trade_price_only
    return "#{last_trade_price} (Last trade price)" if last_trade_price 
    'Unavailable'
  end
  
end
