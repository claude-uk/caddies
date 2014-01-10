class ResponseDomainTextsController < ApplicationController
  # GET /response_domain_texts
  # GET /response_domain_texts.xml
  def index
    @response_domain_texts = ResponseDomainText.includes(:response_domain_all).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @response_domain_texts }
    end
  end

  # GET /response_domain_texts/1
  # GET /response_domain_texts/1.xml
  def show
    @response_domain_text = ResponseDomainText.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response_domain_text }
    end
  end

  # GET /response_domain_texts/new
  # GET /response_domain_texts/new.xml
  def new
    @response_domain_text = ResponseDomainText.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response_domain_text }
    end
  end

  # GET /response_domain_texts/1/edit
  def edit
    @response_domain_text = ResponseDomainText.find(params[:id])
  end

  # POST /response_domain_texts
  # POST /response_domain_texts.xml
  def create
    @response_domain_text = ResponseDomainText.new(params[:response_domain_text])
    @response_domain_text.init

    respond_to do |format|
      if @response_domain_text.save
        format.html { redirect_to(@response_domain_text, :notice => 'Text answer was successfully created.') }
        format.xml  { render :xml => @response_domain_text, :status => :created, :location => @response_domain_text }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response_domain_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /response_domain_texts/1
  # PUT /response_domain_texts/1.xml
  def update
    @response_domain_text = ResponseDomainText.find(params[:id])

    respond_to do |format|
      if @response_domain_text.update_attributes(params[:response_domain_text])
        format.html { redirect_to(@response_domain_text, :notice => 'Text answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response_domain_text.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /response_domain_texts/1
  # DELETE /response_domain_texts/1.xml
  def destroy
    @response_domain_text = ResponseDomainText.find(params[:id])
    @response_domain_text.destroy

    respond_to do |format|
      format.html { redirect_to(response_domain_texts_url) }
      format.xml  { head :ok }
    end
  end
end
