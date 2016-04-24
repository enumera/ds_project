class AddCurrentPriceToFund < ActiveRecord::Migration
  def change
    add_column :funds, :current_price, :float
  end
end
