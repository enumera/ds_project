class CreatePortfolioRecords < ActiveRecord::Migration
  def change
    create_table :portfolio_records do |t|
      t.integer :portfolio_id
      t.integer :fund_id
      t.float :allocation

      t.timestamps
    end
  end
end
