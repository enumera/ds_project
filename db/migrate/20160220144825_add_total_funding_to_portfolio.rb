class AddTotalFundingToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :total_funding, :float
  end
end
