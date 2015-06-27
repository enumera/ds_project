class AddCountryIdToFundRecords < ActiveRecord::Migration
  def change
    add_column :fund_records, :country_id, :integer
  end
end
