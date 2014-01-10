class QuestionItemsController < ApplicationController
  # GET /question_items
  # GET /question_items.xml
  def index
    @question_items = QuestionItem.search_for(params[:search]).includes(:cc_questions)
    #@question_items = QuestionItem.search_for('problem')
    #@question_items = QuestionItem.all
    @instance = Instance.find(1)

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @question_items }
      format.xml # index.xml.erb
    end
  end

  # GET /question_items/1
  # GET /question_items/1.xml
  def show
    @question_item = QuestionItem.find(params[:id])
#    if @question_item.response_domain_all.response_domain_type.id == 2
#      flash[:notice] = "type id is 2"
#    else
#      flash[:notice] = "type id is not 2"
#    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question_item }
    end
  end

  # GET /question_items/new
  # GET /question_items/new.xml
  def new
    @question_item = QuestionItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question_item }
    end
  end

  # GET /question_items/1/edit
  def edit
    @question_item = QuestionItem.find(params[:id])
  end

  # POST /question_items
  # POST /question_items.xml
  def create
    @question_item = QuestionItem.new(params[:question_item])

    respond_to do |format|
      if @question_item.save
        format.html { redirect_to(@question_item, :notice => 'Question item was successfully created.') }
        format.xml  { render :xml => @question_item, :status => :created, :location => @question_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /question_items/1
  # PUT /question_items/1.xml
  def update
    @question_item = QuestionItem.find(params[:id])
#   render :text => params.inspect

    respond_to do |format|
      if @question_item.update_attributes(params[:question_item])
        format.html { redirect_to(@question_item, :notice => 'Question item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /question_items/1
  # DELETE /question_items/1.xml
  def destroy
    @question_item = QuestionItem.find(params[:id])
    @question_item.destroy

    respond_to do |format|
      format.html { redirect_to(question_items_url) }
      format.xml  { head :ok }
    end
  end
end
