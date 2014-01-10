class ResponseDomainNumericsController < ApplicationController
  # GET /response_domain_numerics
  # GET /response_domain_numerics.xml
  def index
    @response_domain_numerics = ResponseDomainNumeric.includes([:numeric_type, :response_domain_all]).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @response_domain_numerics }
    end
  end

  # GET /response_domain_numerics/1
  # GET /response_domain_numerics/1.xml
  def show
    @response_domain_numeric = ResponseDomainNumeric.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response_domain_numeric }
    end
  end

  # GET /response_domain_numerics/new
  # GET /response_domain_numerics/new.xml
  def new
    @response_domain_numeric = ResponseDomainNumeric.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response_domain_numeric }
    end
  end

  # GET /response_domain_numerics/1/edit
  def edit
    @response_domain_numeric = ResponseDomainNumeric.find(params[:id])
  end

  # POST /response_domain_numerics
  # POST /response_domain_numerics.xml
  def create
    @response_domain_numeric = ResponseDomainNumeric.new(params[:response_domain_numeric])
    @response_domain_numeric.init

    respond_to do |format|
      if @response_domain_numeric.save
        format.html { redirect_to(@response_domain_numeric, :notice => 'Numeric answer was successfully created.') }
        format.xml  { render :xml => @response_domain_numeric, :status => :created, :location => @response_domain_numeric }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response_domain_numeric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /response_domain_numerics/1
  # PUT /response_domain_numerics/1.xml
  def update
    @response_domain_numeric = ResponseDomainNumeric.find(params[:id])

    respond_to do |format|
      if @response_domain_numeric.update_attributes(params[:response_domain_numeric])
        format.html { redirect_to(@response_domain_numeric, :notice => 'Numeric answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response_domain_numeric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /response_domain_numerics/1
  # DELETE /response_domain_numerics/1.xml
  def destroy
    @response_domain_numeric = ResponseDomainNumeric.find(params[:id])
    @response_domain_numeric.destroy

    respond_to do |format|
      format.html { redirect_to(response_domain_numerics_url) }
      format.xml  { head :ok }
    end
  end
end
