class CreateFundRecords < ActiveRecord::Migration
  def change
    create_table :fund_records do |t|
      t.string :sector
      t.string :fund
      t.integer :d1
      t.integer :d2
      t.integer :d3
      t.integer :d4
      t.integer :d5
      t.integer :d6
      t.integer :d7
      t.integer :d8
      t.integer :d9
      t.integer :d10
      t.integer :d11
      t.integer :d12
      t.float :wr4
      t.float :wr12
      t.float :wr26
      t.integer :wd4
      t.integer :wd12
      t.integer :wd26
      t.integer :fund_size
      t.string :isin
      t.string :creation_date

      t.timestamps
    end
  end
end
