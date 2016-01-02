class SaltydogGroupsController < ApplicationController
  # GET /saltydog_groups
  # GET /saltydog_groups.json
  def index
    @saltydog_groups = SaltydogGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @saltydog_groups }
    end
  end

  # GET /saltydog_groups/1
  # GET /saltydog_groups/1.json
  def show
    @saltydog_group = SaltydogGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @saltydog_group }
    end
  end

  # GET /saltydog_groups/new
  # GET /saltydog_groups/new.json
  def new
    @saltydog_group = SaltydogGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @saltydog_group }
    end
  end

  # GET /saltydog_groups/1/edit
  def edit
    @saltydog_group = SaltydogGroup.find(params[:id])
  end

  # POST /saltydog_groups
  # POST /saltydog_groups.json
  def create
    @saltydog_group = SaltydogGroup.new(params[:saltydog_group])

    respond_to do |format|
      if @saltydog_group.save
        format.html { redirect_to @saltydog_group, notice: 'Saltydog group was successfully created.' }
        format.json { render json: @saltydog_group, status: :created, location: @saltydog_group }
      else
        format.html { render action: "new" }
        format.json { render json: @saltydog_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /saltydog_groups/1
  # PUT /saltydog_groups/1.json
  def update
    @saltydog_group = SaltydogGroup.find(params[:id])

    respond_to do |format|
      if @saltydog_group.update_attributes(params[:saltydog_group])
        format.html { redirect_to @saltydog_group, notice: 'Saltydog group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @saltydog_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saltydog_groups/1
  # DELETE /saltydog_groups/1.json
  def destroy
    @saltydog_group = SaltydogGroup.find(params[:id])
    @saltydog_group.destroy

    respond_to do |format|
      format.html { redirect_to saltydog_groups_url }
      format.json { head :no_content }
    end
  end
end
