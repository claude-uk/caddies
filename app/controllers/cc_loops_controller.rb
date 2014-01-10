class CcLoopsController < ApplicationController
  # GET /cc_loops
  # GET /cc_loops.xml
  def index
    #@cc_loops = CcLoop.all
    @cc_loops = CcLoop.find(:all, :include => :cc_all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cc_loops }
    end
  end

  # GET /cc_loops/1
  # GET /cc_loops/1.xml
  def show
    @cc_loop = CcLoop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cc_loop }
    end
  end

  # GET /cc_loops/new
  # GET /cc_loops/new.xml
  def new
    @cc_loop = CcLoop.new
    @cc_loop.build_cc_all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cc_loop }
    end
  end

  # GET /cc_loops/1/edit
  def edit
    @cc_loop = CcLoop.find(params[:id])
  end

  # POST /cc_loops
  # POST /cc_loops.xml
  def create
    #I need :parent_id set to 0 by default for itself and next_sib
    if params[:cc_loop][:cc_all_attributes][:parent_id] == ""
      params[:cc_loop][:cc_all_attributes][:parent_id] = "0"
    end
    #we need the parent id to set next_sib
    params[:cc_loop][:cc_all_attributes][:next_sib] += "_"
    params[:cc_loop][:cc_all_attributes][:next_sib] += params[:cc_loop][:cc_all_attributes][:parent_id]    

    @cc_loop = CcLoop.new(params[:cc_loop])

    respond_to do |format|
      if @cc_loop.save
        format.html { redirect_to(@cc_loop, :notice => 'Loop component was successfully created.') }
        format.xml  { render :xml => @cc_loop, :status => :created, :location => @cc_loop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cc_loop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cc_loops/1
  # PUT /cc_loops/1.xml
  def update
    @cc_loop = CcLoop.find(params[:id])

    #we need the parent id to set next_sib
    params[:cc_loop][:cc_all_attributes][:next_sib] += "_"
    params[:cc_loop][:cc_all_attributes][:next_sib] += params[:cc_loop][:cc_all_attributes][:parent_id]

    respond_to do |format|
      if @cc_loop.update_attributes(params[:cc_loop])
        format.html { redirect_to(@cc_loop, :notice => 'Loop component was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cc_loop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cc_loops/1
  # DELETE /cc_loops/1.xml
  def destroy
    @cc_loop = CcLoop.find(params[:id])
    @cc_loop.destroy

    respond_to do |format|
      format.html { redirect_to(cc_loops_url) }
      format.xml  { head :ok }
    end
  end
end
