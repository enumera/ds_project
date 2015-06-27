class FixColumnCountryRel < ActiveRecord::Migration
  def change

    rename_column :fund_records, :country_id, :country_rel_id
  end
  
end
