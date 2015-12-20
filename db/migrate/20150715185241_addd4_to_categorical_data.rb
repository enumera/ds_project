class Addd4ToCategoricalData < ActiveRecord::Migration
  def change
 add_column :categorical_data, :d4, :integer
end
end
