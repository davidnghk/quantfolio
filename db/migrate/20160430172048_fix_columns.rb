class FixColumns < ActiveRecord::Migration
  def change
    rename_column :vehicles, :sharp_ratio, :sharpe_ratio
  end
end
