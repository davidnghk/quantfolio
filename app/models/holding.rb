class Holding < ActiveRecord::Base
  validates :portfolio_id, presence: true
  
  belongs_to :portfolio
  belongs_to :vehicle
end
