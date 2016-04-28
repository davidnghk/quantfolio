class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :ticker
      t.string :name
      t.string :currency
      t.decimal :last_price

      t.timestamps null: false
    end
  end
end
