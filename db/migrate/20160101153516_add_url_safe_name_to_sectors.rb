class AddUrlSafeNameToSectors < ActiveRecord::Migration
  def change
    add_column :sectors, :url_safe, :string
  end
end
