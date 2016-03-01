task :remove_earliest => :environment do 

	file_stats = FileStat.order(:id)


	file_stats[0].destroy
end