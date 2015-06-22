class FixColumnName < ActiveRecord::Migration
   def change
    rename_column :fund_records, :fund, :fund_name
  end
end
