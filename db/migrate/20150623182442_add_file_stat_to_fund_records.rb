class AddFileStatToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :file_stat_id, :integer
  end
end
