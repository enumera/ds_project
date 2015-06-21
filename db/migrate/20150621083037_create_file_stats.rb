class CreateFileStats < ActiveRecord::Migration
  def change
    create_table :file_stats do |t|
      t.integer :records
      t.integer :column_size
      t.string :creation_date
      t.float :time_to_load

      t.timestamps
    end
  end
end
