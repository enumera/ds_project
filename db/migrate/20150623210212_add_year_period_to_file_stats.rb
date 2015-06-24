class AddYearPeriodToFileStats < ActiveRecord::Migration
  def change
    add_column :file_stats, :year_period, :integer
  end
end
