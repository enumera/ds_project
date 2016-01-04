class HomeController < ApplicationController
   def index

    # if @things.nil?
  
      @sectors = Sector.all

      basis_array = set_basis(params)

      @groups =  basis_array[2]
      sector = "All"
      region = "home"

      @time = basis_array[0]
      @measure = basis_array[1]
      @groups =  basis_array[2]


    	@fund_records = FundRecord.fund_records_search( @time,  @measure,  @groups, region, sector)

      @groups_selectable = sl_group_details(@fund_records)

      # binding.pry


      @view_item = "home"
      @search_string = "/home/show_area?continent=home"
      @title = "World View - All Funds"


      stuff = setdata(@fund_records, 1)
      @stats = stuff[0]
      @things = stuff[1].to_json
      @things_view = stuff[1]
      @sectors = get_sector_information(stuff[2])
      # @sectors = stuff[2]
      @continents = stuff[3]

    

  	 respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
     
    end
  end


  def show_area

    basis_array = set_basis(params)

    @time = basis_array[0]
    @measure = basis_array[1]
    @groups =  basis_array[2]

      @sectors = Sector.all

  
  
      if params["continent"] == "home"
        region = "home"
        sector ="All"

         @fund_records = FundRecord.fund_records_search( @time,  @measure,  @groups, region, sector)
         @groups_selectable = sl_group_details(@fund_records)
         @view_item = params["continent"]
         @search_string = "/home/show_area?continent="+params["continent"]
         @title = "World View - All Funds"



        stuff = setdata(@fund_records, 1)

      elsif params["continent"] == "World"

        region = params["continent"]
        sector ="All"

        @fund_records = FundRecord.fund_records_search( @time,  @measure,  @groups, region, sector)

        @groups_selectable = sl_group_details(@fund_records)
        @view_item = params["continent"]
        @search_string = "/home/show_area?continent="+params["continent"]
         @title = "World View - All Funds"

        stuff = setdata(@fund_records, 1)

      else
        region = params["continent"]
        sector ="All"

        @fund_records = FundRecord.fund_records_search( @time,  @measure,  @groups, region, sector)
        @groups_selectable = sl_group_details(@fund_records)
        @view_item = params["continent"]
        @search_string = "/home/show_area?continent="+params["continent"]
         @title = "Fund in " + params["continent"]


        stuff = setdata(@fund_records, 0)

      end

  
      @stats = stuff[0]
      @things = stuff[1].to_json
       @things_view = stuff[1]
       @sectors = get_sector_information(stuff[2])
      # @sectors = stuff[2]
      @continents = stuff[3]

     
    # end

     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
     
    end


  end


  def show_investment_sector

     @sectors = Sector.all

    basis_array = set_basis(params)

    @time = basis_array[0]
    @measure = basis_array[1]
    @groups =  basis_array[2]
   
      region = "home"




    sector_name = Sector.where(url_safe: params["investment_sector"]).select("name")

    sector = sector_name[0].name

    @fund_records = FundRecord.fund_records_search( @time,  @measure,  @groups, region, sector)
    @groups_selectable = sl_group_details(@fund_records)

    # Find all the continents and countries in the funds

    # continents_x = @fund_records.distinct(continent)
    
     continents = @fund_records.map {|t| t.continent}.uniq
     countries = @fund_records.map {|t| t.country_name}.uniq
     


     # sector_url_safe = Sector.find_by_name(params["investment_sector"])
     # binding.pry

      if continents.count == 1

        # then show the world continent map 


         @investment_sector = params["investment_sector"]
         @view_item = continents[0]
         @search_string = "/home/show_investment_sector?investment_sector="+params["investment_sector"]
          @title = "Funds in " + params["investment_sector"]
        stuff = setdata(@fund_records, 0)

      else
   
         @investment_sector = params["investment_sector"]
         @view_item = "home"
         @search_string = "/home/show_investment_sector?investment_sector="+params["investment_sector"]
        stuff = setdata(@fund_records, 1)

        # then show the continent map with the countries

      end

       @title = "Funds in " + params["investment_sector"]
      @stats = stuff[0]
      @things = stuff[1].to_json
       @things_view = stuff[1]
       @sectors = get_sector_information(stuff[2])
      # @sectors = stuff[2]
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

def setdata(fund_records, world_or_continent)
  continents = fund_records.map {|t| t.continent}.uniq
  sectors = fund_records.map {|t| t.sector}.uniq


    return_array = []
    things ={}
    stats = {}


  if world_or_continent == 1
    continents = fund_records.map {|t| t.continent}.uniq
    continents_stuff = get_details(continents,fund_records, stats, things,1, world_or_continent, 1)
   
  else
    countries = fund_records.map {|t| t.country_name}.uniq
    countries_stuff = get_details(countries,fund_records, stats, things,1, world_or_continent, 0 )
    continents_stuff = get_details(continents,fund_records, countries_stuff[0], countries_stuff[1], 1, 1, 0)
   
  end

    sector_stuff = get_details(sectors,fund_records, continents_stuff[0], continents_stuff[1],0,world_or_continent, 0)

    # binding.pry

    sector_stuff.each do |s|
      return_array << s
    end
    return_array << continents 

 
  end


    def get_details(items,fund_records, stats, things, c_or_s, w_or_c, w_or_c_c)

      # c_or_s is continent or country or sector
      # w or c 1, world 0, country


      # if c_or_s == 0
      #   binding.pry
      # end
      
      sl_groups = []


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

            
          
            # binding.pry

            if w_or_c == 1
              # binding.pry
              if t.continent == f 
                count = count + 1
                info_for_stats << t.wr4
              end
            else
              if t.country_name == f 
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
            if t.sector == f 
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

    def get_sector_information(sectors)

        sector_info = []
        sectors.each do |sector|
       
          a = Sector.find_by_name(sector)
          sector_info << [a.name, a.url_safe]
        end
        sector_info
        # binding.pry
    end

    def set_basis(params)



      if params['time']
          time = params['time']
      else
        time = '4'
      end

      if params['measure']
        measure  = params['measure']
      else
        measure = 'Rate'
      end

      if params['groups']
        groups = params['groups']
      else
        groups = ['1']

      end

      basis_array = [time, measure, groups]

    end

  def sl_group_details(fund_records)

      fund_records = fund_records.order("saltydog_group")

      all_sl_group = fund_records.count


      saltydog_group_names = fund_records.all.map {|t| t.saltydog_group}.uniq

      sl_groups = []

     sl_groups << [1, "All", Fund.count]

    saltydog_group_names.each do |sl|
        
       sl_group = SaltydogGroup.find_by_name(sl)

       fund_record_count = fund_records.select {|t| t.saltydog_group == sl}.count

       sl_groups << [sl_group.id, sl_group.name, fund_record_count]

     end

     sl_groups

  end

end
