class AddRegionIdToFunds < ActiveRecord::Migration
  def change
    add_column :funds, :region_id, :integer
  end
end
