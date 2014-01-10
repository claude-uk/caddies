class ResponseDomainCodesController < ApplicationController
  # GET /response_domain_codes
  # GET /response_domain_codes.xml
  def index
    #@response_domain_codes = ResponseDomainCode.all
    #@response_domain_codes = ResponseDomainCode.find(:all, :include => :code_scheme)
    @response_domain_codes = ResponseDomainCode.includes([:code_scheme,:response_domain_all]).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @response_domain_codes }
    end
  end

  # GET /response_domain_codes/1
  # GET /response_domain_codes/1.xml
  def show
    @response_domain_code = ResponseDomainCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response_domain_code }
    end
  end

  # GET /response_domain_codes/new
  # GET /response_domain_codes/new.xml
  def new
    @response_domain_code = ResponseDomainCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response_domain_code }
    end
  end

  # GET /response_domain_codes/1/edit
  def edit
    @response_domain_code = ResponseDomainCode.find(params[:id])
  end

  # POST /response_domain_codes
  # POST /response_domain_codes.xml
  def create
    @response_domain_code = ResponseDomainCode.new(params[:response_domain_code])
    @response_domain_code.init

    respond_to do |format|
      if @response_domain_code.save
        format.html { redirect_to(@response_domain_code, :notice => 'Code answer was successfully created.') }
        format.xml  { render :xml => @response_domain_code, :status => :created, :location => @response_domain_code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response_domain_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /response_domain_codes/1
  # PUT /response_domain_codes/1.xml
  def update
    @response_domain_code = ResponseDomainCode.find(params[:id])

    respond_to do |format|
      if @response_domain_code.update_attributes(params[:response_domain_code])
        format.html { redirect_to(@response_domain_code, :notice => 'Code answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response_domain_code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /response_domain_codes/1
  # DELETE /response_domain_codes/1.xml
  def destroy
    @response_domain_code = ResponseDomainCode.find(params[:id])
    @response_domain_code.destroy

    respond_to do |format|
      format.html { redirect_to(response_domain_codes_url) }
      format.xml  { head :ok }
    end
  end
end
