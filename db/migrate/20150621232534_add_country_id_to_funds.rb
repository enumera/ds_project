class AddCountryIdToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :country_id, :integer
  end
end
