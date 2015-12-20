class CategoricalDataController < ApplicationController
  # GET /categorical_data
  # GET /categorical_data.json
  def index
    @categorical_data = CategoricalDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categorical_data }
    end
  end

  # GET /categorical_data/1
  # GET /categorical_data/1.json
  def show
    @categorical_datum = CategoricalDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @categorical_datum }
    end
  end

  # GET /categorical_data/new
  # GET /categorical_data/new.json
  def new
    @categorical_datum = CategoricalDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @categorical_datum }
    end
  end

  # GET /categorical_data/1/edit
  def edit
    @categorical_datum = CategoricalDatum.find(params[:id])
  end

  # POST /categorical_data
  # POST /categorical_data.json
  def create
    @categorical_datum = CategoricalDatum.new(params[:categorical_datum])

    respond_to do |format|
      if @categorical_datum.save
        format.html { redirect_to @categorical_datum, notice: 'Categorical datum was successfully created.' }
        format.json { render json: @categorical_datum, status: :created, location: @categorical_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @categorical_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categorical_data/1
  # PUT /categorical_data/1.json
  def update
    @categorical_datum = CategoricalDatum.find(params[:id])

    respond_to do |format|
      if @categorical_datum.update_attributes(params[:categorical_datum])
        format.html { redirect_to @categorical_datum, notice: 'Categorical datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @categorical_datum.errors, status: :unprocessable_entity }
      end
    end
  end

    def download

     # [4, 8, 9, 12, 17, 22, 26, 30, 35, 43, 48, 51, 55, 60, 64, 68, 73]

    @records_to_csv = CategoricalDatum.where(file_stat_id:68).order(:fund_name)
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records_to_csv }
      format.csv { render text: @records_to_csv.to_csv }

    end
    
  end

  # DELETE /categorical_data/1
  # DELETE /categorical_data/1.json
  def destroy
    @categorical_datum = CategoricalDatum.find(params[:id])
    @categorical_datum.destroy

    respond_to do |format|
      format.html { redirect_to categorical_data_url }
      format.json { head :no_content }
    end
  end
end
