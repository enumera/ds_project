class Portfolio < ActiveRecord::Base
  attr_accessible :name, :user_id, :portfolio_record_ids, :total_funding
  has_many :portfolio_records
end
