class AddContinentIdToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :continent_id, :integer
  end
end
