class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.references :portfolio, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true
      t.integer :units
      t.decimal :unit_cost
      t.decimal :target_price
      t.decimal :target_weighting

      t.timestamps null: false
    end
  end
end
