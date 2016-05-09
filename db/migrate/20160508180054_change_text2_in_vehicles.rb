class ChangeText2InVehicles < ActiveRecord::Migration
  def change
    change_column :vehicles, :name, :text
  end

end