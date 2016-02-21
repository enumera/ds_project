class PortfolioRecord < ActiveRecord::Base
  attr_accessible :allocation, :fund_id, :portfolio_id, :units, :buy_price, :total_fund, :current_price
  belongs_to :portfolio
  belongs_to :fund
  


  

end
