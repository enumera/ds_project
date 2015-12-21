class HomeController < ApplicationController
  
   def index

    @sectors = Sector.all

  	@fund_records = FundRecord.all

    stuff = setdata(@fund_records)

    # binding.pry
    # @continents = stuff[3]
    @stats = stuff[0]
    @things = stuff[1]
    @sectors = stuff[2]
    @continents = stuff[3]

  	 respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
     
    end


  end

private

  def descriptive_stats(records)
    stats = DescriptiveStatistics::Stats.new(records)
  
  end

def setdata(fund_records)
  continents = fund_records.map {|t| t.fund.continent}.uniq
  sectors = fund_records.map {|t| t.fund.sector}.uniq
    
    return_array = []

   


    things ={}
    stats = {}

    continents_stuff = get_details(continents,fund_records, stats, things,1)
    # binding.pry
    sector_stuff = get_details(sectors,fund_records, continents_stuff[0], continents_stuff[1], 0)


    sector_stuff.each do |s|
      return_array << s
    end
    return_array << continents 

  end


    def get_details(items,fund_records, stats, things, c_or_s)
      items.each do |f|
        # unless f == "none"
          count = 0
          data = {}
        
          # binding.pry
          c = Country.find_by_region(f)

          info_for_stats = []


        if c_or_s == 1

          fund_records.each do |t|
            if t.fund.continent == f 
              count = count + 1
              info_for_stats << t.wr4
            end
          end

          data["region"] = f
          data["value"] = count
          unless f== "none"
            data["hc-key"] = c.continent
          end

           things[f] = data
        else

          fund_records.each do |t|
            if t.fund.sector == f 
              count = count + 1
              info_for_stats << t.wr4
            end
          end
        end


          get_stats = DescriptiveStatistics::Stats.new(info_for_stats)

          stats[f] = ["mean:#{get_stats.mean.round(2)} range:#{get_stats.range.round(2)} max:#{get_stats.max.round(2)} min:#{get_stats.min.round(2)}", count ]

          # things[f] = data
        # end
      end

       a = []

   
      a.push(stats)
      a.push(things)
      a.push(items)
      a


    end

end
