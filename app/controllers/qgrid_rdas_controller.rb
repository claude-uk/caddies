class QgridRdasController < ApplicationController
  # GET /qgrid_rdas
  # GET /qgrid_rdas.xml
  def index
    @qgrid_rdas = QgridRda.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @qgrid_rdas }
    end
  end

  # GET /qgrid_rdas/1
  # GET /qgrid_rdas/1.xml
  def show
    @qgrid_rda = QgridRda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @qgrid_rda }
    end
  end

  # GET /qgrid_rdas/new
  # GET /qgrid_rdas/new.xml
  def new
    @qgrid_rda = QgridRda.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @qgrid_rda }
    end
  end

  # GET /qgrid_rdas/1/edit
  def edit
    @qgrid_rda = QgridRda.find(params[:id])
  end

  # POST /qgrid_rdas
  # POST /qgrid_rdas.xml
  def create
    @qgrid_rda = QgridRda.new(params[:qgrid_rda])

    respond_to do |format|
      if @qgrid_rda.save
        format.html { redirect_to(@qgrid_rda, :notice => 'Qgrid rda was successfully created.') }
        format.xml  { render :xml => @qgrid_rda, :status => :created, :location => @qgrid_rda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @qgrid_rda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /qgrid_rdas/1
  # PUT /qgrid_rdas/1.xml
  def update
    @qgrid_rda = QgridRda.find(params[:id])

    respond_to do |format|
      if @qgrid_rda.update_attributes(params[:qgrid_rda])
        #format.html { redirect_to(@qgrid_rda, :notice => 'Qgrid rda was successfully updated.') }
        format.html { redirect_to(@qgrid_rda.question_grid, :notice => 'Column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @qgrid_rda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /qgrid_rdas/1
  # DELETE /qgrid_rdas/1.xml
  def destroy
    @qgrid_rda = QgridRda.find(params[:id])
    @qgrid_rda.destroy

    respond_to do |format|
      format.html { redirect_to(qgrid_rdas_url) }
      format.xml  { head :ok }
    end
  end
end
