task :update_actual => :environment do

puts Time.now
time_start = Time.now

puts "Started processing...."

funds = Fund.all
funds_count = funds.count
puts funds_count
x = 0

file_stat_array = [60, 64, 68, 73]

  funds.each do |fun|
    a = []
    if fun.fund_records.where{(file_stat_id==file_stat_array[0])}.exists? && fun.fund_records.where{(file_stat_id==file_stat_array[1])}.exists? && fun.fund_records.where{(file_stat_id==file_stat_array[2])}.exists? && fun.fund_records.where{(file_stat_id==file_stat_array[3])}.exists?


      m = fun.fund_records.where{(file_stat_id==file_stat_array[0])}  
        a << m[0] 
      e = fun.fund_records.where{(file_stat_id==file_stat_array[1])}  
        a << e[0]  
      n = fun.fund_records.where{(file_stat_id==file_stat_array[2])}  
        a << n[0]
      h = fun.fund_records.where{(file_stat_id==file_stat_array[3])}  
        a<<h[0]  

        puts "Collected a funds details"
        # binding.pry
      puts "fund #{fun.name} being updated."

        d = a.sort_by {|hsh| hsh[:file_stat_id]}
      # puts d

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
  time_end  = Time.now

  time_to_process = time_end - time_start

  puts "This process took #{time_to_process} seconds to complete"

end

