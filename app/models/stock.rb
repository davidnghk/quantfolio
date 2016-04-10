class Stock < ActiveRecord::Base
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.find_by_code(code_symbol)
    where(code: code_symbol).first
  end 
  
  def self.new_from_lookup(code)
    looked_up_stock = StockQuote::Stock.quote(code)
    return nil unless looked_up_stock.name 
    
    new_stock = new(code: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price 
    new_stock
  end
  
  def price
    closing_price = StockQuote::Stock.quote(code).close
    return "#{closing_price} (Closing)" if closing_price
    
    opening_price = StockQuote::Stock.quote(code).open
    return "#{opening_price} (Opening)" if opening_price
    
    'Unavailable'
    
  end
end
