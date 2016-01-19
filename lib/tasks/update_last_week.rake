task :update_last_week => :environment do
	
	puts "starting rake"

	last_file_stat = FileStat.last
	i = last_file_stat.id

	new_fund_records = FundRecord.where(file_stat_id: i).order(:id)

	begin
		i -=1 
		puts i
		previous_file_stat = FileStat.where(id: i)
		puts previous_file_stat.empty?

	end while previous_file_stat.empty? && i>0

		puts i

		
		new_fund_records.each do |fr|
			# puts fr.fund_name
			n_fr = FundRecord.where(fund_name: fr.fund_name, file_stat_id: i)
			# puts n_fr[0].fund_name
			# binding.pry
			if !n_fr.empty?
				# puts n_fr[0].fund_name
				fr.last_week_change = n_fr[0].wr4
				fr.save

			else
				fr.last_week_change = 0.00
				fr.save
			end
		end
	puts "ending rake"


end