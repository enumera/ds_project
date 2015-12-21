class HomeController < ApplicationController
  
   def index

    @sectors = FundRecord.all.map {|t| t.sector}.uniq

  	@fund_records = FundRecord.where("d1=? and wr4>?", 1, 0)

    @continents = @fund_records.map {|t| t.fund.continent}.uniq
  	@things ={}


  @continents.each do |f|
  		unless f == "none"
  			count = 0
  			data = {}
  			data["region"] = f



        # binding.pry
        c = Country.find_by_region(f)

        data["hc-key"] = c.continent

  			@fund_records.each do |t|
	  			if t.fund.continent == f 
	  				count = count + 1
	  			end
  			end

  			data["value"] = count

  			@things[f] = data
  		end
  	end



  	 respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @things }
     
    end


  end
end
