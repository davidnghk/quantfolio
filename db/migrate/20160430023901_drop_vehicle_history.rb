class DropVehicleHistory < ActiveRecord::Migration
  def up
    drop_table :vehicle_histories
  end

  def down
    create_table :vehicle_histories do |t|
      t.date :trade_date
      t.string :symbol
      t.decimal :open
      t.decimal :volume
      t.decimal :high
      t.decimal :low
      t.decimal :close
      t.decimal :adj_close

      t.timestamps null: false
    end
  end
end
