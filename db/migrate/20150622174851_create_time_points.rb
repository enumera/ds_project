class CreateTimePoints < ActiveRecord::Migration
  def change
    create_table :time_points do |t|
      t.string :time_period

      t.timestamps
    end
  end
end
