class AddCurrentPortfolioIdToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :current_portfolio_id, :integer
  end
end
