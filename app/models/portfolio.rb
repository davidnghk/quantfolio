class Portfolio < ActiveRecord::Base
  validates :code, presence: true
  validates :name, presence: true
  validates :cash, presence: true
  
  belongs_to :user
  has_many :holdings, :dependent => :destroy
  
  def can_add_vehicle?(ticker_symbol)
    under_vehicle_limit? && !vehicle_already_added?(ticker_symbol)
  end
  
  def under_vehicle_limit?
    (holdings.count < 10)    
  end
  
  def vehicle_already_added?(ticker_symbol)
    vehicle = vehicle.find_by_ticker(ticker_symbol)
    return false unless vehicle
    holdings.where(vehicle_id: vehicle.id).exists?
  end
  
end
