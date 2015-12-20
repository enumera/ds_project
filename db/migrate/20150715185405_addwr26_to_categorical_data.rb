class Addwr26ToCategoricalData < ActiveRecord::Migration
  def change
    add_column :categorical_data, :wr26, :float
  end

end
