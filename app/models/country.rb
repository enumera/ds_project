class Country < ActiveRecord::Base
  attr_accessible :name, :region, :alias

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      a = row.to_hash
      unless Country.where(name: a["name"]).exists?
        Country.create! a
      end
    end
  end
end
