task :update_actual => :environment do

funds = Fund.all

a = []

  funds.each do |fun|
    if fun.fund_records.where{(file_stat_id==64)}.exists? && fun.fund_records.where{(file_stat_id==68)}.exists? && fun.fund_records.where{(file_stat_id==73)}.exists?
      e = fun.fund_records.where{(file_stat_id==64)}  
      a << e[0]  
      n = fun.fund_records.where{(file_stat_id==68)}  
      a << n[0]
      h = fun.fund_records.where{(file_stat_id==73)}  
      a<<h[0]  
    end  
  end

  c = a.map {|au| au.fund_id}.uniq

c.each do |cu|
  b= []
  a.each
  c.each do |cu|
    b= a.map do |au|
      if au.fund_id == cu
          au
      end  
    end  

    b.delete(nil)

  d = b.sort_by {|hsh| hsh[:file_stat_id]}
      d[0].next_wd_four = d[1].wr4
      d[1].next_wd_four = d[2].wr4
      d[0].save
      d[1].save
    end 
end

