task :create_categorical => :environment do

puts "Start processing"
puts Time.now

  records = FundRecord.where{(file_stat_id == 68) & (next_wd_four != nil)}
puts "records found"
  records.each do |record|

    # decile_record = [record.d1, record.d2, record.d3, record.d4].join()

    CategoricalDatum.create(continent: record.fund.continent, country: record.fund.country_name, fund_name: record.fund_name, next_wd_four: record.next_wd_four, sector: record.sector, d1: record.d1, d2: record.d2, d3: record.d3, d4: record.d4, wr4: record.wr4, wr12: record.wr12, wr26: record.wr26, file_stat_id: 68)
  end
  puts "processed"
end
