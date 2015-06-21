class Fund < ActiveRecord::Base
  attr_accessible :continent, :country, :name, :sector, :isin, :fund_record_ids

  has_many :fund_records
  has_one :country

end
