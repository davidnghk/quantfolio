class Vehicle < ActiveRecord::Base
  belongs_to :parent, :class_name => "Vehicle", :foreign_key => :parent_id
  has_many :children, :class_name => "Vehicle"
  
  has_many :holdings
  has_many :vehicle_histories
  has_many :vehicle_prices
     
  def self.search(search)
    where("return IS NOT NULL AND (ticker LIKE? OR name LIKE ?)", "#{search}%", "%#{search}%")
  end   
     
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
      # v.name        = StockQuote::Stock.quote(v.ticker).name
      v.last_price  = StockQuote::Stock.quote(v.ticker).last_trade_price_only
      v.save
    end
  end
  
  def self.get_ticker_history(ticker_symbol)
    
    v=Vehicle.find_by_ticker(ticker_symbol)
    VehiclePrice.where(:vehicle_id => v.id).delete_all
    begin
      history = StockQuote::Stock.history(v.ticker, Date.today-1.years, Date.today)
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
       
end 

def self.calc_stats(ticker_symbol)  
    @v=Vehicle.find_by_ticker(ticker_symbol)
    prev_adj_close = -1 
    return_sum = 0.0
    @v.vehicle_prices.sort_by { |m| m[:trade_date] }.each do |row|
      if prev_adj_close > 0 
         row.return = (row.adj_close - prev_adj_close) / prev_adj_close
         return_sum = return_sum + Math.log(1+row.return)
      end
      prev_adj_close = row.adj_close
      row.save
    end   
        
    vehicle_price = @v.vehicle_prices.where("return is NOT NULL").extend(DescriptiveStatistics)
    @v.no_of_prices = vehicle_price.number(&:return)
        
    if @v.no_of_prices > 20
      @v.return = Math.exp(return_sum) - 1
      @v.risk = vehicle_price.standard_deviation(&:return) * Math.sqrt(250) 
      @v.alpha = 0
      @v.beta = 1.0
      @v.sharpe_ratio = (@v.return - 0.02)/@v.risk
    else
      @v.return = nil
      @v.risk = nil
      @v.alpha = nil 
      @v.beta = nil 
      @v.sharpe_ratio = nil 
     end
      @v.save     
   
  end  
  
  def self.benchmark(ticker_symbol)  
    require 'statsample'
    
    @a=Vehicle.find_by_ticker(ticker_symbol)
    @b=Vehicle.where(" id = 395" )
    
    @x = @a.vehicle_prices.order(:trade_date)
    @y = @b.vehicle_prices.order(:trade_date)
    
    ss_analysis("Statsample::Bivariate.correlation_matrix") do
      ds=data_frame(@x, @y)
      cm=cor(ds) 
      summary(cm)
    end
   
  end 
  
  def self.get_history
    get_ticker_history('^GSPC')
    veh = Vehicle.where(" parent_id is NOT NULL ")
    veh.each do |row|
      get_ticker_history(row.ticker)
      calc_stats(row.ticker)
    end      
  end   
  
  def self.set_index
    @v = Vehicle.where(id = 395)
    @v.parent_id = nil
    @v.save     
  end  
  
end
