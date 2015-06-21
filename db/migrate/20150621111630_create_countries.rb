class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :region
      t.string :alias

      t.timestamps
    end
  end
end
