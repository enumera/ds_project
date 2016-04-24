require 'rails_helper'
require 'capybara/rails'

RSpec.describe FundsController, :type => :controller do 

	before(:each) do
		fund = Fund.create(name: "Big equity fund")
		request.cookies["fund_count"] = 0

	end


	describe "GET set_fund_selection" do
	    it "has a 200 status code" do
	      get :set_fund_selection, :fund_id => 1
	      expect(response.status).to eq(200)
	    end
  	end



	context "to allow a non-signed up user to save and delete fund selection" do
		fund = Fund.create(name: "Big equity fund")

		describe "GET set_fund_selection" do

			it "increments the fund count by 1 when a fund is selected" do
				get :set_fund_selection, :fund_id => fund.id

				expect(response.cookies["fund_count"]).to eq("1")

			end

			it "stores a cookie with the fund id" do
				get :set_fund_selection, :fund_id => fund.id

				count = response.cookies["fund_count"]

				count = count.to_i

				expect(count).to eq(1)

				search_string = "#{fund.id}"

				expect(search_string).to eq("#{fund.id}")

				expect(response.cookies["funds_#{fund.id}"]).to eq(fund.id.to_s)

			end
		end

		describe "GET remove_fund_selection" do

			it "reduces the count by 1 when a fund is removed" do
				count1 = response.cookies["fund_count"].to_i
				expect(count1).to eq(0)

				get :remove_fund_selection, :fund_id => fund.id
				count1 = response.cookies["fund_count"].to_i
				expect(count1).to eq(-1)

			end


			it "removes a cookie with the fund_id" do
				get :set_fund_selection, :fund_id => fund.id
				count1 = response.cookies["fund_count"].to_i
				expect(count1).to eq(1)
				expect(response.cookies["funds_#{fund.id}"]).to eq(fund.id.to_s)

				get :remove_fund_selection, :fund_id => fund.id

				count = response.cookies["fund_count"]
				expect(response.cookies["funds_#{fund.id}"]).to eq(nil)
				expect(count).to eq("0")

			end
		end
	end

	context "to pick up the cookie selection and find funds" do
		describe "pick up the funds held in cookies" do
			it "finds the number of funds selected" do
				fund1 = Fund.create(name: "Big equity fund")
				fund2 = Fund.create(name: "Big equity fund")
				fund3 = Fund.create(name: "Big equity fund")

				get :set_fund_selection, :fund_id => fund1.id
				get :set_fund_selection, :fund_id => fund2.id
				get :set_fund_selection, :fund_id => fund3.id

				expect(response.cookies["fund_count"].to_i).to eq(3)

				get :index
				
			end

			it "finds no funds and does not error if no funds are available" do
				expect(response.cookies["fund_count"].to_i).to eq(0)
				get :index
			end


		end


	end


	
end