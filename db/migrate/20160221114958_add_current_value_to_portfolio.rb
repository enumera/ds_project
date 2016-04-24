class AddCurrentValueToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :current_value, :float
  end
end
