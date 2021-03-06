class QuestionGridsController < ApplicationController
  # GET /question_grids
  # GET /question_grids.xml
  def index
    @question_grids = QuestionGrid.search_for(params[:search]).includes(:cc_questions)
    @instance = Instance.find(1)	#for xml output?

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @question_grids }
    end
  end

  # GET /question_grids/1
  # GET /question_grids/1.xml
  def show
    @question_grid = QuestionGrid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question_grid }
    end
  end

  # GET /question_grids/new
  # GET /question_grids/new.xml
  def new
    @question_grid = QuestionGrid.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question_grid }
    end
  end

  # GET /question_grids/1/edit
  def edit
    @question_grid = QuestionGrid.find(params[:id])
  end

  # POST /question_grids
  # POST /question_grids.xml
  def create
    #I create and add the column params from the existing params so that the columns are created as nested attributes
    cols = CodeScheme.find(params[:question_grid][:horizontal_codelist_id]).codes
    carray = []
    cols.each do |col|
      c = Hash.new
    	c[:code_id] = col.id
    	carray.push(c)
    end
    params[:question_grid][:columns_attributes] = carray
    #render :text => params.inspect

    @question_grid = QuestionGrid.new(params[:question_grid])

    respond_to do |format|
      if @question_grid.save
        format.html { redirect_to(@question_grid, :notice => 'Question grid was successfully created.') }
        format.xml  { render :xml => @question_grid, :status => :created, :location => @question_grid }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question_grid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /question_grids/1
  # PUT /question_grids/1.xml
  def update
    @question_grid = QuestionGrid.find(params[:id])
    #if the horizontal codelist is changed, I reset the columns
    if @question_grid.horizontal_codelist_id.to_s != params[:question_grid][:horizontal_codelist_id]
    	#render :text => @question_grid.horizontal_codelist_id.to_s + ' diff ' + params[:question_grid][:horizontal_codelist_id]
    	carray = []
    	#columns to destroy
    	#@question_grid.columns.destroy_all()
    	@question_grid.columns.each do |col|
    		c = Hash.new
    		c[:id] = col.id
    		c[:_destroy] = '1'
    		carray.push(c)
    	end
    	#columns to add
    	cols = CodeScheme.find(params[:question_grid][:horizontal_codelist_id]).codes
    	cols.each do |col|
      	c = Hash.new
    		c[:code_id] = col.id
    		carray.push(c)
    	end
    	params[:question_grid][:columns_attributes] = carray
      #render :text => params.inspect
    #else
      #render :text => params.inspect
    end

    respond_to do |format|
      if @question_grid.update_attributes(params[:question_grid])
        format.html { redirect_to(@question_grid, :notice => 'Question grid was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question_grid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /question_grids/1
  # DELETE /question_grids/1.xml
  def destroy
    @question_grid = QuestionGrid.find(params[:id])
    @question_grid.destroy

    respond_to do |format|
      format.html { redirect_to(question_grids_url) }
      format.xml  { head :ok }
    end
  end
end
