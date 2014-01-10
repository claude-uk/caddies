class CcStatementsController < ApplicationController
  # GET /cc_statements
  # GET /cc_statements.xml
  def index
    #@cc_statements = CcStatement.all
    @cc_statements = CcStatement.find(:all, :include => :cc_all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cc_statements }
    end
  end

  # GET /cc_statements/1
  # GET /cc_statements/1.xml
  def show
    @cc_statement = CcStatement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cc_statement }
    end
  end

  # GET /cc_statements/new
  # GET /cc_statements/new.xml
  def new
    @cc_statement = CcStatement.new
    @cc_statement.build_cc_all
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cc_statement }
    end
  end

  # GET /cc_statements/1/edit
  def edit
    @cc_statement = CcStatement.find(params[:id])
  end

  # POST /cc_statements
  # POST /cc_statements.xml
  def create
    #I need :parent_id set to 0 by default for itself and next_sib
    if params[:cc_statement][:cc_all_attributes][:parent_id] == ""
      params[:cc_statement][:cc_all_attributes][:parent_id] = "0"
    end
    #we need the parent id to set next_sib
    params[:cc_statement][:cc_all_attributes][:next_sib] += "_"
    params[:cc_statement][:cc_all_attributes][:next_sib] += params[:cc_statement][:cc_all_attributes][:parent_id]    

    #render :text => params.inspect
    #logger.debug "xxx in create1"
    @cc_statement = CcStatement.new(params[:cc_statement])
    #render :text => "===" + @cc_statement.to_yaml + "==="
    
    respond_to do |format|
      if @cc_statement.save
        format.html { redirect_to(@cc_statement, :notice => 'Statement component was successfully created.') }
        format.xml  { render :xml => @cc_statement, :status => :created, :location => @cc_statement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cc_statement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cc_statements/1
  # PUT /cc_statements/1.xml
  def update
    @cc_statement = CcStatement.find(params[:id])

    #we need the parent id to set next_sib
    params[:cc_statement][:cc_all_attributes][:next_sib] += "_"
    params[:cc_statement][:cc_all_attributes][:next_sib] += params[:cc_statement][:cc_all_attributes][:parent_id]    

    respond_to do |format|
      if @cc_statement.update_attributes(params[:cc_statement])
        format.html { redirect_to(@cc_statement, :notice => 'Statement component was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cc_statement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cc_statements/1
  # DELETE /cc_statements/1.xml
  def destroy
    @cc_statement = CcStatement.find(params[:id])
    @cc_statement.destroy

    respond_to do |format|
      format.html { redirect_to(cc_statements_url) }
      format.xml  { head :ok }
    end
  end
end
