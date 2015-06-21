class FileStatsController < ApplicationController
  # GET /file_stats
  # GET /file_stats.json
  def index
    @file_stats = FileStat.page(params[:page]).per(20)
    @file_stats_count  = FileStat.count
   

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @file_stats }
    end
  end

  # GET /file_stats/1
  # GET /file_stats/1.json
  def show
    @file_stat = FileStat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @file_stat }
    end
  end

  # GET /file_stats/new
  # GET /file_stats/new.json
  def new
    @file_stat = FileStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @file_stat }
    end
  end

  # GET /file_stats/1/edit
  def edit
    @file_stat = FileStat.find(params[:id])
  end

  # POST /file_stats
  # POST /file_stats.json
  def create
    @file_stat = FileStat.new(params[:file_stat])

    respond_to do |format|
      if @file_stat.save
        format.html { redirect_to @file_stat, notice: 'File stat was successfully created.' }
        format.json { render json: @file_stat, status: :created, location: @file_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @file_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /file_stats/1
  # PUT /file_stats/1.json
  def update
    @file_stat = FileStat.find(params[:id])

    respond_to do |format|
      if @file_stat.update_attributes(params[:file_stat])
        format.html { redirect_to @file_stat, notice: 'File stat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @file_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_stats/1
  # DELETE /file_stats/1.json
  def destroy
    @file_stat = FileStat.find(params[:id])
    @file_stat.destroy

    respond_to do |format|
      format.html { redirect_to file_stats_url }
      format.json { head :no_content }
    end
  end

  def show_last
    @file_stat = FileStat.order("created_at DESC").first
    
  end

  def file_already_loaded
    
    
  end
end
