require 'rails_helper'

RSpec.describe PortfolioRecord, :type => :model do
 	it {should belong_to(:fund)}
 	it {should belong_to(:portfolio)}
end
