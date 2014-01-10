class QiRdasController < ApplicationController
  # GET /qi_rdas
  # GET /qi_rdas.xml
  def index
    @qi_rdas = QiRda.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @qi_rdas }
    end
  end

  # GET /qi_rdas/1
  # GET /qi_rdas/1.xml
  def show
    @qi_rda = QiRda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @qi_rda }
    end
  end

  # GET /qi_rdas/new
  # GET /qi_rdas/new.xml
  def new
    @qi_rda = QiRda.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @qi_rda }
    end
  end

  # GET /qi_rdas/1/edit
  def edit
    @qi_rda = QiRda.find(params[:id])
  end

  # POST /qi_rdas
  # POST /qi_rdas.xml
  def create
    @qi_rda = QiRda.new(params[:qi_rda])

    respond_to do |format|
      if @qi_rda.save
        format.html { redirect_to(@qi_rda, :notice => 'Qi rda was successfully created.') }
        format.xml  { render :xml => @qi_rda, :status => :created, :location => @qi_rda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @qi_rda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /qi_rdas/1
  # PUT /qi_rdas/1.xml
  def update
    @qi_rda = QiRda.find(params[:id])

    respond_to do |format|
      if @qi_rda.update_attributes(params[:qi_rda])
        format.html { redirect_to(@qi_rda, :notice => 'Qi rda was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @qi_rda.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /qi_rdas/1
  # DELETE /qi_rdas/1.xml
  def destroy
    @qi_rda = QiRda.find(params[:id])
    @qi_rda.destroy

    respond_to do |format|
      format.html { redirect_to(qi_rdas_url) }
      format.xml  { head :ok }
    end
  end
end
