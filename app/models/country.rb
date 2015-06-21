class Country < ActiveRecord::Base
  attr_accessible :name, :region

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Country.create! row.to_hash
    end
  end
end
