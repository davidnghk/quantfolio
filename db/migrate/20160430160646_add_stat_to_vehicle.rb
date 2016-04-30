class AddStatToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :return, :decimal 
    add_column :vehicles, :risk, :decimal 
    add_column :vehicles, :sharp_ratio, :decimal     
    add_column :vehicles, :beta, :decimal 
    add_column :vehicles, :alpha, :decimal 
    add_column :vehicles, :no_of_prices, :integer 
    add_column :vehicles, :parent_id, :integer 
  end
end
