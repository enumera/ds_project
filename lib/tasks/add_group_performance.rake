task :add_group_performance => :environment do
	
	fund_records = FundRecord.all

	fund_records.each do |fr|
		
			if fr.d1 < fr.d2 
				fr.group_performance = "Rising" 
			elsif fr.d1 == fr.d2
				fr.group_performance = "Stable"
			else
			fr.group_performance = "Falling" 
		end
		fr.save 
	end

end