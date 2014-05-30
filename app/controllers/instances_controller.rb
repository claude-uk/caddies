class InstancesController < ApplicationController
  # GET /cc_alls
  # GET /cc_alls.xml
  def doc
    @docroot = CcAll.find(1)
  
    respond_to do |format|
      format.html # doc.html.erb
      format.xml  { render :xml => @docroot }
    end
  end


  # GET /instances
  # GET /instances.xml
  def index
    @instances = Instance.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @instances }
    end
  end

  # GET /instances/1
  # GET /instances/1.xml
  def show
    #@instance = Instance.find(params[:id])
    @instance = Instance.first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instance }
    end
  end

  # GET /instances/1/ddi3.xml
  def ddi3
    @instance = Instance.first
    @question_items = QuestionItem.all
    @question_grids = QuestionGrid.all
    @instructions = Instruction.all
    @categories = Category.all
    @code_schemes = CodeScheme.find(:all, :include => :codes)
    @response_domain_texts = ResponseDomainText.all
    @response_domain_numerics = ResponseDomainNumeric.all
    @response_domain_datetimes = ResponseDomainDatetime.all
    #Really I should trace it back from the text id of the topsequence in instance...
    @first_construct = CcAll.find(1)
    @output_option = "Metadata originally captured using CADDIES(Centre for Longitudinal Studies) version 0.12.1 with the xml library option"

    respond_to do |format|
      format.html # show.html.erb
      #format.xml  { render :xml => @instance }
      format.xml # ddi3.xml.erb
    end
  end

  # GET /instances/1/ddi3clean.xml
  def ddi3clean
    @instance = Instance.first
    @question_items = QuestionItem.all_used_in_top_sequence
    @question_grids = QuestionGrid.all_used_in_top_sequence
    @instructions = Instruction.all_used_in_top_sequence(@question_items, @question_grids)
    @code_schemes = CodeScheme.all_used_in_top_sequence(@question_items, @question_grids)
    @categories = Category.all_used_in_top_sequence(@code_schemes)
    @response_domain_texts = ResponseDomainText.all_used_in_top_sequence(@question_items, @question_grids)
    @response_domain_numerics = ResponseDomainNumeric.all_used_in_top_sequence(@question_items, @question_grids)
    @response_domain_datetimes = ResponseDomainDatetime.all_used_in_top_sequence(@question_items, @question_grids)
    @first_construct = CcAll.find(1)
    @output_option = "Metadata originally captured using CADDIES(Centre for Longitudinal Studies) version 0.12.1 with the xml compact option"

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :ddi3 } # uses same template as ddi3: ddi3.xml.erb
    end
  end

  # GET /instances/1/stats.xml
  def stats
    @instance = Instance.first
    @instance.set_statistics

   	#render :text => @instance.to_yaml
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instance }
      format.csv  { render :csv => @instance }
    end
  end

  # GET /instances/1/qlist.txt
  def qlist
    @instance = Instance.first
    @instance.set_qlist()
    
    respond_to do |format|
      #format.html # show.html.erb
      format.text  { render :text => @instance.qlist.join("\n") }
    end
  end

  # GET /instances/new
  # GET /instances/new.xml
  def new
    @instance = Instance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @instance }
    end
  end

  # GET /instances/1/edit
  def edit
    #@instance = Instance.find(params[:id])
    @instance = Instance.first
  end

  # POST /instances
  # POST /instances.xml
  def create
    @instance = Instance.new(params[:instance])

    respond_to do |format|
      if @instance.save
        format.html { redirect_to(@instance, :notice => 'Instance was successfully created.') }
        format.xml  { render :xml => @instance, :status => :created, :location => @instance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @instance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /instances/1
  # PUT /instances/1.xml
  def update
    @instance = Instance.find(params[:id])

    respond_to do |format|
      if @instance.update_attributes(params[:instance])
        format.html { redirect_to(@instance, :notice => 'Instance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instances/1
  # DELETE /instances/1.xml
  def destroy
    @instance = Instance.find(params[:id])
    @instance.destroy

    respond_to do |format|
      format.html { redirect_to(instances_url) }
      format.xml  { head :ok }
    end
  end
end
