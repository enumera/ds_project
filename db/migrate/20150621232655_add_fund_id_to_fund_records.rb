class AddFundIdToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :fund_id, :integer
  end
end
