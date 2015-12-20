class CreateCategoricalData < ActiveRecord::Migration
  def change
    create_table :categorical_data do |t|
      t.string :fund_name
      t.string :sector
      t.string :continent
      t.string :country
      t.string :deciles
      t.string :next_wd_four

      t.timestamps
    end
  end
end
