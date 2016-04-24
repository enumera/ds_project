require 'rails_helper'

RSpec.describe Fund, :type => :model do 

	context "a fund must have many fund records" do
		it {should have_many(:fund_records)}
		it {should have_many(:portfolio_records)}
	end


	context "get the lastest prices for a fund" do

		it "find the fund price for a fund" do
			fund = Fund.create(name: "This fund", isin: "GB00BC5ZKC50.L" )

			fund_price = fund.find_price(fund.isin)

			expect(fund_price).to eq(138.0)
		end
	end


	
end