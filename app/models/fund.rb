class Fund < ActiveRecord::Base
  attr_accessible :continent, :country, :name, :sector, :isin
end
