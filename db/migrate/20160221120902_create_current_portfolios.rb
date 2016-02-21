class CreateCurrentPortfolios < ActiveRecord::Migration
  def change
    create_table :current_portfolios do |t|
      t.integer :portfolio_id
      t.float :current_value

      t.timestamps
    end
  end
end
