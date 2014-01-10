class CcQuestionsController < ApplicationController
  # GET /cc_questions
  # GET /cc_questions.xml
  def index
    #@cc_questions = CcQuestion.all
    @cc_questions = CcQuestion.find(:all, :include => [:cc_all, :question_item])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cc_questions }
    end
  end

  # GET /cc_questions/1
  # GET /cc_questions/1.xml
  def show
    @cc_question = CcQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cc_question }
    end
  end

  # GET /cc_questions/new
  # GET /cc_questions/new.xml
  def new
    @cc_question = CcQuestion.new
    @cc_question.build_cc_all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cc_question }
    end
  end

  # GET /cc_questions/1/edit
  def edit
    @cc_question = CcQuestion.find(params[:id])
  end

  # POST /cc_questions
  # POST /cc_questions.xml
  def create
    #I need :parent_id set to 0 by default for itself and next_sib
    if params[:cc_question][:cc_all_attributes][:parent_id] == ""
      params[:cc_question][:cc_all_attributes][:parent_id] = "0"
    end
    #we need the parent id to set next_sib
    params[:cc_question][:cc_all_attributes][:next_sib] += "_"
    params[:cc_question][:cc_all_attributes][:next_sib] += params[:cc_question][:cc_all_attributes][:parent_id]    

    @cc_question = CcQuestion.new(params[:cc_question])

    respond_to do |format|
      if @cc_question.save
        format.html { redirect_to(@cc_question, :notice => 'Question component was successfully created.') }
        format.xml  { render :xml => @cc_question, :status => :created, :location => @cc_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cc_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cc_questions/1
  # PUT /cc_questions/1.xml
  def update
    @cc_question = CcQuestion.find(params[:id])

    #we need the parent id to set next_sib
    params[:cc_question][:cc_all_attributes][:next_sib] += "_"
    params[:cc_question][:cc_all_attributes][:next_sib] += params[:cc_question][:cc_all_attributes][:parent_id]    

    respond_to do |format|
      if @cc_question.update_attributes(params[:cc_question])
        format.html { redirect_to(@cc_question, :notice => 'Question component was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cc_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cc_questions/1
  # DELETE /cc_questions/1.xml
  def destroy
    @cc_question = CcQuestion.find(params[:id])
    @cc_question.destroy

    respond_to do |format|
      format.html { redirect_to(cc_questions_url) }
      format.xml  { head :ok }
    end
  end
end
