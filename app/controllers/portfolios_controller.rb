class PortfoliosController < ApplicationController
  # GET /portfolios
  # GET /portfolios.json
  def index
      @portfolios = Portfolio.all

      @portfolios.each do |portfolio|
        portfolio.portfolio_records.each do |record|
          if record.price_updated_last != Date.today
            if record.fund.name != "Cash"
                record.current_price = record.fund.find_price(record.fund.isin)
                record.current_value = record.units * record.current_price
                record.price_updated_last = Date.today
                record.save
                puts "updating price for #{record.fund.name}"
              else
                record.current_price = 1.00
                record.current_value = record.units * record.current_price
                record.save
            end

          end

        end
        portfolio.current_portfolio.current_value = portfolio.get_current_value(portfolio)
  
      end

  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    @portfolio = Portfolio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @portfolio }
    end
  end

  # GET /portfolios/new
  # GET /portfolios/new.json
  def new
   

     if cookies["fund_count"]

        funds_map = cookies.map {|key| key }

         @funds_selected = FundRecord.find_funds(funds_map)

         # binding.pry

        unless @funds_selected[1].empty?

          @funds_selected[1].each do |fund| 
            # yahoo_isin = fund.isin + ".L"
            fund.current_price = fund.find_price(fund.isin)
          end
        end
      end
        
    @portfolio = Portfolio.new

  end

  # GET /portfolios/1/edit
  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @portfolio = Portfolio.new(params[:portfolio])
    
    respond_to do |format|
      if @portfolio.save

        total_fund_allocation = 0.00

        (1..(params.count-6)).each do |n|
          fund = Fund.find(params["portfolio_record_#{n}"][:fund_id])
          price = fund.find_price(fund.isin)
          allocation = params["portfolio_record_#{n}"][:allocation].to_i
          total_fund_allocation += allocation
          units = (@portfolio.total_funding.to_f * allocation) / price

          PortfolioRecord.create(portfolio_id: @portfolio.id, allocation: params["portfolio_record_#{n}"][:allocation], fund_id: params["portfolio_record_#{n}"][:fund_id], buy_price: price, units: units.round(3), total_fund: @portfolio.total_funding)

        end

        cash_fund = Fund.find_by_name("Cash")
        cash_price = cash_fund.current_price
        cash_allocation = 100 - total_fund_allocation
        units = (@portfolio.total_funding.to_f * cash_allocation) / cash_price

        PortfolioRecord.create(portfolio_id: @portfolio.id, allocation: cash_allocation, buy_price: cash_price, units: units.round(3), fund_id: cash_fund.id  ,total_fund: @portfolio.total_funding)
        
        newcurrent = CurrentPortfolio.create(portfolio_id: @portfolio.id)
        
        @portfolio.current_portfolio = newcurrent
        @portfolio.save
     
        portfolio_value = @portfolio.get_current_value(@portfolio)

        @portfolio.current_portfolio.current_value = portfolio_value

        @portfolio.current_portfolio.save

        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully created.' }
        format.json { render json: @portfolio, status: :created, location: @portfolio }
      else
        format.html { render action: "new" }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /portfolios/1
  # PUT /portfolios/1.json
  def update
    @portfolio = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio.update_attributes(params[:portfolio])
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy

    respond_to do |format|
      format.html { redirect_to portfolios_url }
      format.json { head :no_content }
    end
  end
end
