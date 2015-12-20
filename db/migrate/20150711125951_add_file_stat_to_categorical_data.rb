class AddFileStatToCategoricalData < ActiveRecord::Migration
  def change
    add_column :categorical_data, :file_stat_id, :integer
  end
end
