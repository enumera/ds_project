class AddTimePointIdToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :time_point_id, :integer
  end
end
