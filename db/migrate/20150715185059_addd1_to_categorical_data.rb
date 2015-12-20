class Addd1ToCategoricalData < ActiveRecord::Migration
  def change
  add_column :categorical_data, :d1, :integer
end
end
