class CategoricalDatum < ActiveRecord::Base
  attr_accessible :continent, :country, :deciles, :fund_name, :next_wd_four, :sector, :file_stat_id, :d1, :d2, :d3, :d4, :wr4, :wr12, :wr26

  def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |categorical|
        csv << categorical.attributes.values_at(*column_names)
      end
    end
  end


end
