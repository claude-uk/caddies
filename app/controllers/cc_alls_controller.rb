class CcAllsController < ApplicationController
  # GET /cc_alls
  # GET /cc_alls.xml
  def spine
    @spineroot = CcAll.find(1)
    @atticroot = CcAll.find(0)
  
    respond_to do |format|
      format.html # spine.html.erb
      format.xml  { render :xml => @spineroot }
    end
  end




  # GET /cc_alls
  # GET /cc_alls.xml
  def index
    @spineroot = CcAll.find(1)
    @cc_alls = CcAll.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cc_alls }
    end
  end

  # GET /cc_alls/1
  # GET /cc_alls/1.xml
  def show
    @cc_all = CcAll.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cc_all }
    end
  end

  # GET /cc_alls/new
  # GET /cc_alls/new.xml
  def new
    @cc_all = CcAll.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cc_all }
    end
  end

  # GET /cc_alls/1/edit
  def edit
    @cc_all = CcAll.find(params[:id])
  end

  # POST /cc_alls
  # POST /cc_alls.xml
  def create
    @cc_all = CcAll.new(params[:cc_all])

    respond_to do |format|
      if @cc_all.save
        format.html { redirect_to(@cc_all, :notice => 'Cc all was successfully created.') }
        format.xml  { render :xml => @cc_all, :status => :created, :location => @cc_all }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cc_all.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cc_alls/1
  # PUT /cc_alls/1.xml
  def update
    logger.debug "xxx in update   #{params}"
    @cc_all = CcAll.find(params[:id])
    logger.debug "xxx in update #{@cc_all.attributes.inspect}"

    respond_to do |format|
      if @cc_all.update_attributes(params[:cc_all])
        #format.html { redirect_to(@cc_all, :notice => 'Cc all was successfully updated.') }
        format.html { redirect_to(spine_path, :notice => 'Cc all was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cc_all.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cc_alls/1
  # DELETE /cc_alls/1.xml
  def destroy
    @cc_all = CcAll.find(params[:id])
    @cc_all.destroy

    respond_to do |format|
      format.html { redirect_to(cc_alls_url) }
      format.xml  { head :ok }
    end
  end
end
