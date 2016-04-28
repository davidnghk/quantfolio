class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :code
      t.string :name
      t.decimal :capital
      t.decimal :cash
      t.date :start_date
      t.date :end_date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
