class Region < ActiveRecord::Base
  attr_accessible :region

  has_many :funds

    
    def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |fund_record|
        csv << fund_record.attributes.values_at(*column_names)
      end
    end
  end
end
