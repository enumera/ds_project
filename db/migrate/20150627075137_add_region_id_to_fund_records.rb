class AddRegionIdToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :region_id, :integer
  end
end
