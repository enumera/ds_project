class AddCurrentPriceToPortfolioRecord < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :current_price, :float
  end
end
