class CcIfthenelsesController < ApplicationController
  # GET /cc_ifthenelses
  # GET /cc_ifthenelses.xml
  def index
    #@cc_ifthenelses = CcIfthenelse.all
    @cc_ifthenelses = CcIfthenelse.find(:all, :include => :cc_all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cc_ifthenelses }
    end
  end

  # GET /cc_ifthenelses/1
  # GET /cc_ifthenelses/1.xml
  def show
    @cc_ifthenelse = CcIfthenelse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cc_ifthenelse }
    end
  end

  # GET /cc_ifthenelses/new
  # GET /cc_ifthenelses/new.xml
  def new
    @cc_ifthenelse = CcIfthenelse.new
    @cc_ifthenelse.build_cc_all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cc_ifthenelse }
    end
  end

  # GET /cc_ifthenelses/1/edit
  def edit
    @cc_ifthenelse = CcIfthenelse.find(params[:id])
  end

  # POST /cc_ifthenelses
  # POST /cc_ifthenelses.xml
  def create
    #I need :parent_id set to 0 by default for itself and next_sib
    if params[:cc_ifthenelse][:cc_all_attributes][:parent_id] == ""
      params[:cc_ifthenelse][:cc_all_attributes][:parent_id] = "0"
    end
    #we need the parent id to set next_sib
    params[:cc_ifthenelse][:cc_all_attributes][:next_sib] += "_"
    params[:cc_ifthenelse][:cc_all_attributes][:next_sib] += params[:cc_ifthenelse][:cc_all_attributes][:parent_id]    

    @cc_ifthenelse = CcIfthenelse.new(params[:cc_ifthenelse])

    respond_to do |format|
      if @cc_ifthenelse.save
        format.html { redirect_to(@cc_ifthenelse, :notice => 'Ifthenelse component was successfully created.') }
        format.xml  { render :xml => @cc_ifthenelse, :status => :created, :location => @cc_ifthenelse }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cc_ifthenelse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cc_ifthenelses/1
  # PUT /cc_ifthenelses/1.xml
  def update
    @cc_ifthenelse = CcIfthenelse.find(params[:id])

    #we need the parent id to set next_sib
    params[:cc_ifthenelse][:cc_all_attributes][:next_sib] += "_"
    params[:cc_ifthenelse][:cc_all_attributes][:next_sib] += params[:cc_ifthenelse][:cc_all_attributes][:parent_id]    

    respond_to do |format|
      if @cc_ifthenelse.update_attributes(params[:cc_ifthenelse])
        format.html { redirect_to(@cc_ifthenelse, :notice => 'Ifthenelse component was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cc_ifthenelse.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cc_ifthenelses/1
  # DELETE /cc_ifthenelses/1.xml
  def destroy
    @cc_ifthenelse = CcIfthenelse.find(params[:id])
    @cc_ifthenelse.destroy

    respond_to do |format|
      format.html { redirect_to(cc_ifthenelses_url) }
      format.xml  { head :ok }
    end
  end
end
