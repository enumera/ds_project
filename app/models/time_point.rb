class TimePoint < ActiveRecord::Base
  attr_accessible :time_period, :file_stat_ids

  has_many :file_stats
end
