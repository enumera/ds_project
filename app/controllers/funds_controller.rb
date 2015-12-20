class FundsController < ApplicationController
  # GET /funds
  # GET /funds.json
  def index
   countries = ["Brazil", "China", "Hong Kong", "India", "Japan", "Russia", "UK", "USA"]

   regions = ["BRIC", "The Americas", "Asia", "Europe", "World"]

   @fund_countries = []
   @fund_ias = []


   investment_areas = {}


   countries.each do |country|
     investment_areas = {}
    investment_areas["country"] = country
    investment_areas["country_funds"] = Fund.where(country_name: country).count
    @fund_countries << investment_areas
  end

  regions.each do |region|
    investment_areas = {}
    investment_areas["region"] = region
    investment_areas["region_funds"] = Fund.where(continent: region).count
    @fund_ias << investment_areas
  end
    



    @funds = Fund.where("country_name !=?", "none").page(params[:page]).per(20)
    @funds_count  = Fund.where("country_name !=?", "none").count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @funds }
    end
  end



  def download

     # [4, 8, 9, 12, 17, 22, 26, 30, 35, 43, 48, 51, 55, 60, 64, 68, 73]

    @funds_to_csv = Fund.order(:name)
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fund_to_csv }
      format.csv { render text: @funds_to_csv.to_csv }

    end
    
  end

  # GET /funds/1
  # GET /funds/1.json
  def show
    @fund = Fund.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fund }
    end
  end

  # GET /funds/new
  # GET /funds/new.json
  def new
    @fund = Fund.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fund }
    end
  end

  # GET /funds/1/edit
  def edit
    @fund = Fund.find(params[:id])
  end

  # POST /funds
  # POST /funds.json
  def create
    @fund = Fund.new(params[:fund])

    respond_to do |format|
      if @fund.save
        format.html { redirect_to @fund, notice: 'Fund was successfully created.' }
        format.json { render json: @fund, status: :created, location: @fund }
      else
        format.html { render action: "new" }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /funds/1
  # PUT /funds/1.json
  def update
    @fund = Fund.find(params[:id])

    respond_to do |format|
      if @fund.update_attributes(params[:fund])
        format.html { redirect_to @fund, notice: 'Fund was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funds/1
  # DELETE /funds/1.json
  def destroy
    @fund = Fund.find(params[:id])
    @fund.destroy

    respond_to do |format|
      format.html { redirect_to funds_url }
      format.json { head :no_content }
    end
  end
end
