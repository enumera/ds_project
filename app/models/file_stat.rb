class FileStat < ActiveRecord::Base
  attr_accessible :column_size, :creation_date, :records, :time_to_load, :time_point_id, :fund_record_ids, :year_period

  belongs_to :time_point
  has_many :fund_records

  
end
