class DropHoldings < ActiveRecord::Migration
  def change
    drop_table :holdings
  end
end
