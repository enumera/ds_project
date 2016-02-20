require 'rails_helper'

RSpec.describe Fund, :type => :model do 

	context "a fund must have many fund records" do
		it {should have_many(:fund_records)}
		it {should have_many(:portfolio_records)}
	end


	
end