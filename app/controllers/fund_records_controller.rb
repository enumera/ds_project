class FundRecordsController < ApplicationController
  # GET /fund_records
  # GET /fund_records.json
  def index
    @fund_records = FundRecord.page(params[:page]).per(20)
    @record_count  = FundRecord.count
    @last_file =FileStat.order("created_at DESC").first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fund_records }
    end
  end

  # GET /fund_records/1
  # GET /fund_records/1.json
  def show
    @fund_record = FundRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fund_record }
    end
  end

  # GET /fund_records/new
  # GET /fund_records/new.json
  def new
    @fund_record = FundRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fund_record }
    end
  end

  # GET /fund_records/1/edit
  def edit
    @fund_record = FundRecord.find(params[:id])
  end

  # POST /fund_records
  # POST /fund_records.json
  def create
    @fund_record = FundRecord.new(params[:fund_record])

    respond_to do |format|
      if @fund_record.save
        format.html { redirect_to @fund_record, notice: 'Fund record was successfully created.' }
        format.json { render json: @fund_record, status: :created, location: @fund_record }
      else
        format.html { render action: "new" }
        format.json { render json: @fund_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    # binding.pry
    # unless FundRecord.check_creation_date(params[:file])
    if FundRecord.import(params[:file])
      redirect_to show_last_file_path, notice: "records loaded !!"
    else
      redirect_to file_already_loaded_path, notice: "File has already been loaded"
    end
  end

  # PUT /fund_records/1
  # PUT /fund_records/1.json
  def update
    @fund_record = FundRecord.find(params[:id])

    respond_to do |format|
      if @fund_record.update_attributes(params[:fund_record])
        format.html { redirect_to @fund_record, notice: 'Fund record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fund_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fund_records/1
  # DELETE /fund_records/1.json
  def destroy
    @fund_record = FundRecord.find(params[:id])
    @fund_record.destroy

    respond_to do |format|
      format.html { redirect_to fund_records_url }
      format.json { head :no_content }
    end
  end
end
