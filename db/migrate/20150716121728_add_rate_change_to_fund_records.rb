class AddRateChangeToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :rate_change, :float
  end
end
