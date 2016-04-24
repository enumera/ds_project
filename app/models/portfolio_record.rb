class PortfolioRecord < ActiveRecord::Base
  attr_accessible :allocation, :fund_id, :portfolio_id, :units, :buy_price, :total_fund, :current_price, :current_value, :price_updated_last
  belongs_to :portfolio
  belongs_to :fund
  
end
