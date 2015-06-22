class AddTimePointIdToFileStat < ActiveRecord::Migration
  def change
    add_column :file_stats, :time_point_id, :integer
  end
end
