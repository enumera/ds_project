class Addwr4ToCategoricalData < ActiveRecord::Migration
  def change
    add_column :categorical_data, :wr4, :float
  end

end
