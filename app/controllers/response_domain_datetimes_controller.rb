class ResponseDomainDatetimesController < ApplicationController
  # GET /response_domain_datetimes
  # GET /response_domain_datetimes.xml
  def index
    @response_domain_datetimes = ResponseDomainDatetime.includes(:response_domain_all).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @response_domain_datetimes }
    end
  end

  # GET /response_domain_datetimes/1
  # GET /response_domain_datetimes/1.xml
  def show
    @response_domain_datetime = ResponseDomainDatetime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response_domain_datetime }
    end
  end

  # GET /response_domain_datetimes/new
  # GET /response_domain_datetimes/new.xml
  def new
    @response_domain_datetime = ResponseDomainDatetime.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response_domain_datetime }
    end
  end

  # GET /response_domain_datetimes/1/edit
  def edit
    @response_domain_datetime = ResponseDomainDatetime.find(params[:id])
  end

  # POST /response_domain_datetimes
  # POST /response_domain_datetimes.xml
  def create
    @response_domain_datetime = ResponseDomainDatetime.new(params[:response_domain_datetime])
    @response_domain_datetime.init

    respond_to do |format|
      if @response_domain_datetime.save
        format.html { redirect_to(@response_domain_datetime, :notice => 'Time and date answer was successfully created.') }
        format.xml  { render :xml => @response_domain_datetime, :status => :created, :location => @response_domain_datetime }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response_domain_datetime.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /response_domain_datetimes/1
  # PUT /response_domain_datetimes/1.xml
  def update
    @response_domain_datetime = ResponseDomainDatetime.find(params[:id])

    respond_to do |format|
      if @response_domain_datetime.update_attributes(params[:response_domain_datetime])
        format.html { redirect_to(@response_domain_datetime, :notice => 'Time and date answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response_domain_datetime.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /response_domain_datetimes/1
  # DELETE /response_domain_datetimes/1.xml
  def destroy
    @response_domain_datetime = ResponseDomainDatetime.find(params[:id])
    @response_domain_datetime.destroy

    respond_to do |format|
      format.html { redirect_to(response_domain_datetimes_url) }
      format.xml  { head :ok }
    end
  end
end
