class AddBuyPriceToPortfolioRecord < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :buy_price, :float
  end
end
