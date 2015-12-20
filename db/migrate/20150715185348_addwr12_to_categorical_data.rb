class Addwr12ToCategoricalData < ActiveRecord::Migration
  

    def change
    add_column :categorical_data, :wr12, :float
  end
end
