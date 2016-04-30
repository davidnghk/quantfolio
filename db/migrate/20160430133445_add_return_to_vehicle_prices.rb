class AddReturnToVehiclePrices < ActiveRecord::Migration
  def change
      add_column :vehicle_prices, :return, :decimal 
  end
end
