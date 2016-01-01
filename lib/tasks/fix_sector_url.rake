task :fix_sector_url => :environment do 
	

	puts "Starting fixing sectors"

	Sector.delete_all

	fl = FileStat.find(1)

	FundRecord.create_sectors(fl)

	puts "processed!"


end