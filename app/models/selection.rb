class Selection < ActiveRecord::Base
  attr_accessible :fund_id, :portfolio_id
  belongs_to :fund
  belongs_to :portfolio
end
