class Country < ActiveRecord::Base
  attr_accessible :name, :region, :alias, :fund_ids, :iso, :continent

  has_many :funds

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      a = row.to_hash
      unless Country.where(name: a["name"]).exists?
        Country.create! a
    #   else
    #     unless  a["iso"].nil?
    #       c = Country.find_by_name(a["name"])
    #       unless c.iso.nil?
    #         c = Country.find_by_name(a["name"])
    #         c.iso = a["iso"]
    #         c.continent = a["continent"]
    #         c.save
    #       else
    #         c.continent = a["continent"]
    #         c.save
    #       end
    #     end
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
