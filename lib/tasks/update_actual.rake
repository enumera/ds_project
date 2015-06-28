task :update_actual => :environment do

puts Time.now

puts "Started processing...."

funds = Fund.all
funds_count = funds.count
puts funds_count
x = 0

  funds.each do |fun|
    a = []
    if fun.fund_records.where{(file_stat_id==60)}.exists? && fun.fund_records.where{(file_stat_id==64)}.exists? && fun.fund_records.where{(file_stat_id==68)}.exists? && fun.fund_records.where{(file_stat_id==73)}.exists?


      m = fun.fund_records.where{(file_stat_id==60)}  
        a << m[0] 
      e = fun.fund_records.where{(file_stat_id==64)}  
        a << e[0]  
      n = fun.fund_records.where{(file_stat_id==68)}  
        a << n[0]
      h = fun.fund_records.where{(file_stat_id==73)}  
        a<<h[0]  

        puts "Collected a funds details"
        # binding.pry
      puts "fund #{fun.name} being updated."

        d = a.sort_by {|hsh| hsh[:file_stat_id]}
      puts d

        d[0].next_wd_four = d[1].wr4
        d[1].next_wd_four = d[2].wr4
        d[2].next_wd_four = d[3].wr4

        d[0].save
        d[1].save
        d[2].save
        x = x+1

    puts "fund #{fun.name} being saved."
     puts "fund #{fun.name} being saved. Funds #{x} of #{funds_count} completed"
    end  
  end
  puts "Finished processing"
  puts Time.now

end

