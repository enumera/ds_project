class HomeController < ApplicationController
  
   def index

    if @things.nil?
  
      @sectors = Sector.all

    	@fund_records = FundRecord.order("WR4 DESC")



      @view_item = "home"
      @search_string = "/home/show_area?continent=home"


      stuff = setdata(@fund_records, 1)

      # binding.pry
      # @continents = stuff[3]
      @stats = stuff[0]
      @things = stuff[1]
      @sectors = stuff[2]
      @continents = stuff[3]

    end

  	 respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
     
    end
  end


  def show_area


    if @things.nil?

      @sectors = Sector.all


    if params["continent"] == "home"

       @fund_records = FundRecord.order("WR4 DESC").includes(:fund)
       @view_item = params["continent"]
       @search_string = "/home/show_area?continent="+params["continent"]
       @title = "World View - All Funds"


      stuff = setdata(@fund_records, 1)

    elsif params["continent"] == "World"

      @fund_records = FundRecord.joins(:fund).where("funds.continent = ?", params["continent"])

      @view_item = params["continent"]
      @search_string = "/home/show_area?continent="+params["continent"]


      stuff = setdata(@fund_records, 1)

    else

      @fund_records = FundRecord.joins(:fund).where("funds.continent = ?", params["continent"])

      @view_item = params["continent"]
      @search_string = "/home/show_area?continent="+params["continent"]


      stuff = setdata(@fund_records, 0)

    end

      # binding.pry
      # @continents = stuff[3]
      @stats = stuff[0]
      @things = stuff[1]
      @sectors = stuff[2]
      @continents = stuff[3]


    end

     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
     
    end


  end


  def show_investment_sector

     # binding.pry

    # Find funds in the investment sector

    @fund_records = FundRecord.where(sector: params["investment_sector"])

    # Find all the continents and countries in the funds
    # binding.pry
     continents = @fund_records.map {|t| t.fund.continent}.uniq
     countries = @fund_records.map {|t| t.fund.country_name}.uniq

     # binding.pry

      if continents.count == 1

        # then show the world continent map 

          # binding.pry

         @view_item = continents[0]
         @search_string = "/home/show_investment_sector?investment_sector="+params["investment_sector"]

        stuff = setdata(@fund_records, 0)

      else

         @view_item = "home"
         @search_string = "/home/show_investment_sector?investment_sector="+params["investment_sector"]
        stuff = setdata(@fund_records, 1)

        # then show the continent map with the countries

      end

      @stats = stuff[0]
      @things = stuff[1]
      @sectors = stuff[2]
      @continents = stuff[3]

    

     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
     
    end

    # Request the data


  end






private

  def descriptive_stats(records)
    stats = DescriptiveStatistics::Stats.new(records)
  
  end

def setdata(fund_records, world_or_continent)
  continents = fund_records.map {|t| t.fund.continent}.uniq
  sectors = fund_records.map {|t| t.fund.sector}.uniq

    return_array = []
    things ={}
    stats = {}


  if world_or_continent == 1
    continents = fund_records.map {|t| t.fund.continent}.uniq
    continents_stuff = get_details(continents,fund_records, stats, things,1, world_or_continent, 1)
  else
    countries = fund_records.map {|t| t.fund.country_name}.uniq

    # binding.pry
    countries_stuff = get_details(countries,fund_records, stats, things,1, world_or_continent, 0 )
    # binding.pry
    continents_stuff = get_details(continents,fund_records, countries_stuff[0], countries_stuff[1], 1, 1, 0)
    # binding.pry
  end

    sector_stuff = get_details(sectors,fund_records, continents_stuff[0], continents_stuff[1],0,world_or_continent, 0)

    # binding.pry

    sector_stuff.each do |s|
      return_array << s
    end
    return_array << continents 

    # binding.pry
  end


    def get_details(items,fund_records, stats, things, c_or_s, w_or_c, w_or_c_c)

      # c_or_s is continent or country or sector
      # w or c 1, world 0, country


      # if c_or_s == 0
      #   binding.pry
      # end

      items.each do |f|
        count = 0
        data = {}
        
       
        if w_or_c == 1

          c = Country.find_by_region(f)

        else

          c = Country.find_by_name(f)

        end

        info_for_stats = []


        if c_or_s == 1

          fund_records.each do |t|
          
            if w_or_c == 1
              # binding.pry
              if t.fund.continent == f 
                count = count + 1
                info_for_stats << t.wr4
              end
            else
              if t.fund.country_name == f 
                count = count + 1
                info_for_stats << t.wr4
              end
            end
          end

   

          if w_or_c == 1 && w_or_c_c == 1

            data["region"] = f
            unless f== "none"
              data["hc-key"] = c.continent
            end
            data["value"] = count
            things[f] = data

          elsif w_or_c == 0  

              data["country"] = f
              data["hc-key"] = c.iso.downcase
                data["value"] = count
              #  binding.pry
              things[f] = data

          end

        else
          fund_records.each do |t|
            if t.fund.sector == f 
              count = count + 1
              info_for_stats << t.wr4
            end
          end
        end

       
        get_stats = DescriptiveStatistics::Stats.new(info_for_stats)

        if get_stats.mean < 0
          color_class = "down"
        elsif get_stats.mean == 0
          color_class = "stable"
        else
          color_class = "up"
        end

        stats[f] = ["mean:#{get_stats.mean.round(2)} range:#{get_stats.range.round(2)} max:#{get_stats.max.round(2)} min:#{get_stats.min.round(2)}", count, color_class ]

        # if it is a country update it

        # if it is an investment sector then don't update it

        # if it is a continent with a country then dont update it

        # if it 




        if c_or_s == 1 
          data["mean"] = get_stats.mean.round(2)
          things[f] = data
        end
      end

      # binding.pry

      a = []
      a.push(stats)
      a.push(things)
      a.push(items)
      a


    end



end
