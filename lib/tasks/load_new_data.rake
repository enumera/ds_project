task :load_new_data => :environment do 
	puts "start processing"
	
	FundRecord.import(ENV["FILE"])

end