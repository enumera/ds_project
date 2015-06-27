class AddNextWdFourToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :next_wd_four, :float
  end
end
