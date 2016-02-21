class AddUnitsToPortfolioRecord < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :units, :float
  end
end
