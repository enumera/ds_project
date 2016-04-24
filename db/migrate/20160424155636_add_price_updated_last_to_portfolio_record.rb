class AddPriceUpdatedLastToPortfolioRecord < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :price_updated_last, :date
  end
end
