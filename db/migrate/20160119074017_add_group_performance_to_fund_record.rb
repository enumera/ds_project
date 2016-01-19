class AddGroupPerformanceToFundRecord < ActiveRecord::Migration
  def change
    add_column :fund_records, :group_performance, :string
  end
end
