class CreateVehicleHistories < ActiveRecord::Migration
  def change
    create_table :vehicle_histories do |t|
      t.references :vehicle, index: true, foreign_key: true
      t.date :trade_date
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
