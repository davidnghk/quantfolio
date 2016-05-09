class ChangeTextInVehicles < ActiveRecord::Migration
  def up
    change_column :vehicles, :name, :text
  end

  def down
    change_column :vehicles, :name, :string
  end
end
