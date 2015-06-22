class TimePointsController < ApplicationController
  # GET /time_points
  # GET /time_points.json
  def index
    @time_points = TimePoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @time_points }
    end
  end

  # GET /time_points/1
  # GET /time_points/1.json
  def show
    @time_point = TimePoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_point }
    end
  end

  # GET /time_points/new
  # GET /time_points/new.json
  def new
    @time_point = TimePoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_point }
    end
  end

  # GET /time_points/1/edit
  def edit
    @time_point = TimePoint.find(params[:id])
  end

  # POST /time_points
  # POST /time_points.json
  def create
    @time_point = TimePoint.new(params[:time_point])

    respond_to do |format|
      if @time_point.save
        format.html { redirect_to @time_point, notice: 'Time point was successfully created.' }
        format.json { render json: @time_point, status: :created, location: @time_point }
      else
        format.html { render action: "new" }
        format.json { render json: @time_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_points/1
  # PUT /time_points/1.json
  def update
    @time_point = TimePoint.find(params[:id])

    respond_to do |format|
      if @time_point.update_attributes(params[:time_point])
        format.html { redirect_to @time_point, notice: 'Time point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_points/1
  # DELETE /time_points/1.json
  def destroy
    @time_point = TimePoint.find(params[:id])
    @time_point.destroy

    respond_to do |format|
      format.html { redirect_to time_points_url }
      format.json { head :no_content }
    end
  end
end
