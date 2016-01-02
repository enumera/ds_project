class AddSaltydogGroupTofund < ActiveRecord::Migration
  def change
    add_column :funds, :saltydog_group_id, :integer
  end
end
