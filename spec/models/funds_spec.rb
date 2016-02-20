require 'rails_helper'

RSpec.describe Fund, :type => :model do 

	context "a fund must have many fund records" do
		it {should have_many(:fund_records)}
	end


	
end