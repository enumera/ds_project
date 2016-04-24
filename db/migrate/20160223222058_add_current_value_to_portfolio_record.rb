class AddCurrentValueToPortfolioRecord < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :current_value, :float
  end
end
