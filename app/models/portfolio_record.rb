class PortfolioRecord < ActiveRecord::Base
  attr_accessible :allocation, :fund_id, :portfolio_id
  belongs_to :portfolio
  belongs_to :fund

end
