class CreateCountryRelevants < ActiveRecord::Migration
  def change
    create_table :country_relevants do |t|
      t.string :name

      t.timestamps
    end
  end
end
