class Country < ActiveRecord::Base
  attr_accessible :name, :region, :alias

  has_many :funds

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      a = row.to_hash
      unless Country.where(name: a["name"]).exists?
        Country.create! a
      end
    end
  end

  def self.to_csv

    CSV.generate do |csv|
      csv << column_names
      all.each do |country|
        csv << country.attributes.values_at(*column_names)
      end
    end
  end


end
