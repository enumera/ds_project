class SaltydogGroup < ActiveRecord::Base
  attr_accessible :description, :name, :fund_ids
  has_many :funds
end
