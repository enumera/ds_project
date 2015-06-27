class Fund < ActiveRecord::Base
  attr_accessible :continent, :country_name, :name, :sector, :isin, :fund_record_ids, :country_id, :region_id

  has_many :fund_records
  belongs_to :country
  belongs_to :region

end
