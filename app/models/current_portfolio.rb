class CurrentPortfolio < ActiveRecord::Base
  attr_accessible :current_value, :portfolio_id
  belongs_to :portfolio

end
