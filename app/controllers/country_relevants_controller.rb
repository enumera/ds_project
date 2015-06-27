class CountryRelevantsController < ApplicationController
  # GET /country_relevants
  # GET /country_relevants.json
  def index
    @country_relevants = CountryRelevant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @country_relevants }
    end
  end

  # GET /country_relevants/1
  # GET /country_relevants/1.json
  def show
    @country_relevant = CountryRelevant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country_relevant }
    end
  end

  # GET /country_relevants/new
  # GET /country_relevants/new.json
  def new
    @country_relevant = CountryRelevant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @country_relevant }
    end
  end

  # GET /country_relevants/1/edit
  def edit
    @country_relevant = CountryRelevant.find(params[:id])
  end

  # POST /country_relevants
  # POST /country_relevants.json
  def create
    @country_relevant = CountryRelevant.new(params[:country_relevant])

    respond_to do |format|
      if @country_relevant.save
        format.html { redirect_to @country_relevant, notice: 'Country relevant was successfully created.' }
        format.json { render json: @country_relevant, status: :created, location: @country_relevant }
      else
        format.html { render action: "new" }
        format.json { render json: @country_relevant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /country_relevants/1
  # PUT /country_relevants/1.json
  def update
    @country_relevant = CountryRelevant.find(params[:id])

    respond_to do |format|
      if @country_relevant.update_attributes(params[:country_relevant])
        format.html { redirect_to @country_relevant, notice: 'Country relevant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @country_relevant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /country_relevants/1
  # DELETE /country_relevants/1.json
  def destroy
    @country_relevant = CountryRelevant.find(params[:id])
    @country_relevant.destroy

    respond_to do |format|
      format.html { redirect_to country_relevants_url }
      format.json { head :no_content }
    end
  end
end
