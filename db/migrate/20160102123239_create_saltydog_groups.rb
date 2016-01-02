class CreateSaltydogGroups < ActiveRecord::Migration
  def change
    create_table :saltydog_groups do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
