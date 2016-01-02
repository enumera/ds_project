class Fund < ActiveRecord::Base
  attr_accessible :continent, :country_name, :name, :sector, :isin, :fund_record_ids, :country_id, :region_id, :saltydog_group_id

  has_many :fund_records
  belongs_to :country
  belongs_to :region
  belongs_to :saltydog_group

  
    def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |fund_record|
        csv << fund_record.attributes.values_at(*column_names)
      end
    end
  end

end
