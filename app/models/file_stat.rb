class FileStat < ActiveRecord::Base
  attr_accessible :column_size, :creation_date, :records, :time_to_load, :time_point_id

  belongs_to :time_point
end
