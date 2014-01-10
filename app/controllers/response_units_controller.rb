class ResponseUnitsController < ApplicationController
  # GET /response_units
  # GET /response_units.xml
  def index
    @response_units = ResponseUnit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @response_units }
    end
  end

  # GET /response_units/1
  # GET /response_units/1.xml
  def show
    @response_unit = ResponseUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response_unit }
    end
  end

  # GET /response_units/new
  # GET /response_units/new.xml
  def new
    @response_unit = ResponseUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response_unit }
    end
  end

  # GET /response_units/1/edit
  def edit
    @response_unit = ResponseUnit.find(params[:id])
  end

  # POST /response_units
  # POST /response_units.xml
  def create
    @response_unit = ResponseUnit.new(params[:response_unit])

    respond_to do |format|
      if @response_unit.save
        format.html { redirect_to(@response_unit, :notice => 'Interviewee was successfully created.') }
        format.xml  { render :xml => @response_unit, :status => :created, :location => @response_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /response_units/1
  # PUT /response_units/1.xml
  def update
    @response_unit = ResponseUnit.find(params[:id])

    respond_to do |format|
      if @response_unit.update_attributes(params[:response_unit])
        format.html { redirect_to(@response_unit, :notice => 'Interviewee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /response_units/1
  # DELETE /response_units/1.xml
  def destroy
    @response_unit = ResponseUnit.find(params[:id])
    @response_unit.destroy

    respond_to do |format|
      format.html { redirect_to(response_units_url) }
      format.xml  { head :ok }
    end
  end
end
