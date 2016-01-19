class AddLastWeekChangeToFundRecord < ActiveRecord::Migration
  def change
    add_column :fund_records, :last_week_change, :float
  end
end
