class AddTotalFundToPortfolioRecord < ActiveRecord::Migration
  def change
    add_column :portfolio_records, :total_fund, :float
  end
end
