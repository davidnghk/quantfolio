class Vehicle < ActiveRecord::Base
  has_many :holdings
  has_many :vehicle_histories
  has_many :vehicle_prices
  
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
  
  def self.refresh_price 
    Vehicle.all.each do |v|
      v.name        = StockQuote::Stock.quote(v.ticker).name
      v.last_price  = StockQuote::Stock.quote(v.ticker).last_trade_price_only
      v.save
    end
  end
  
  def self.get_ticker_history(ticker_symbol)
    
    v=Vehicle.find_by_ticker(ticker_symbol)
    VehiclePrice.where(:vehicle_id => v.id).delete_all
    begin
      history = StockQuote::Stock.history(v.ticker, Date.today-3.years, Date.today)
         
      history.each do |sqh|
      vh = VehiclePrice.new
      vh.vehicle_id = v.id
      vh.trade_date = sqh.date
      vh.volume = sqh.volume
      vh.open = sqh.open
      vh.high = sqh.high
      vh.low  = sqh.low
      vh.close = sqh.close
      vh.adj_close = sqh.adj_close
      vh.save
      end
    rescue StandardError
      history = nil
    end
         
    vp = VehiclePrice.where(:vehicle_id => v.id).order(:trade_date) 
    prev_adj_close = -1    
    vp.each do |row|
      if prev_adj_close > 0 
         row.return = (row.adj_close - prev_adj_close) / row.adj_close
      end
      prev_adj_close = row.adj_close
      row.save
    end    
    
    vehicle_price = VehiclePrice.where(:vehicle_id => v.id).extend(DescriptiveStatistics)
    v.return = vehicle_price.mean(&:return) * 260 
    v.risk = vehicle_price.standard_deviation(&:return) * Math.sqrt(260) 
    v.no_of_prices = vehicle_price.number(&:return)
    if v.risk > 0
      v.sharpe_ratio = (v.return - 0.02)/v.risk
    end 
    v.save    
  end  
  
  def self.get_history
    veh = Vehicle.all
    
    veh.each do |row|
      get_ticker_history(row.ticker)
    end      
  end  
  
  
end
