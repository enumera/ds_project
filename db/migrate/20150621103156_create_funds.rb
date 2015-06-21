class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :name
      t.string :sector
      t.string :country
      t.string :continent
      t.string :isin

      t.timestamps
    end
  end
end
