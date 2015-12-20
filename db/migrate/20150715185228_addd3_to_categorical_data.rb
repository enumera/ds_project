class Addd3ToCategoricalData < ActiveRecord::Migration
  def change
    add_column :categorical_data, :d3, :integer
  end

end
