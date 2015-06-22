class FixColumnCountry < ActiveRecord::Migration
  def change
    rename_column :funds, :country, :country_name
  end
end
