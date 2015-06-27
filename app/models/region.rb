class Region < ActiveRecord::Base
  attr_accessible :region

  has_many :funds
end
