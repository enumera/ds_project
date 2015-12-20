class Addd2ToCategoricalData < ActiveRecord::Migration
  def change
    add_column :categorical_data, :d2, :integer
  end

 

end
