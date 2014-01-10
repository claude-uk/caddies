class CcSequencesController < ApplicationController
  # GET /cc_sequences
  # GET /cc_sequences.xml
  def index
    #@cc_sequences = CcSequence.all
    @cc_sequences = CcSequence.find(:all, :include => :cc_all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cc_sequences }
    end
  end

  # GET /cc_sequences/1
  # GET /cc_sequences/1.xml
  def show
    @cc_sequence = CcSequence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cc_sequence }
    end
  end

  # GET /cc_sequences/new
  # GET /cc_sequences/new.xml
  def new
    @cc_sequence = CcSequence.new
    @cc_sequence.build_cc_all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cc_sequence }
    end
  end

  # GET /cc_sequences/1/edit
  def edit
    @cc_sequence = CcSequence.find(params[:id])
  end

  # POST /cc_sequences
  # POST /cc_sequences.xml
  def create
    #I need :parent_id set to 0 by default for itself and next_sib
    if params[:cc_sequence][:cc_all_attributes][:parent_id] == ""
      params[:cc_sequence][:cc_all_attributes][:parent_id] = "0"
    end
    #we need the parent id to set next_sib
    params[:cc_sequence][:cc_all_attributes][:next_sib] += "_"
    params[:cc_sequence][:cc_all_attributes][:next_sib] += params[:cc_sequence][:cc_all_attributes][:parent_id]    

    @cc_sequence = CcSequence.new(params[:cc_sequence])

    respond_to do |format|
      if @cc_sequence.save
        format.html { redirect_to(@cc_sequence, :notice => 'Sequence component was successfully created.') }
        format.xml  { render :xml => @cc_sequence, :status => :created, :location => @cc_sequence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cc_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cc_sequences/1
  # PUT /cc_sequences/1.xml
  def update
    @cc_sequence = CcSequence.find(params[:id])

    #we need the parent id to set next_sib
    params[:cc_sequence][:cc_all_attributes][:next_sib] += "_"
    params[:cc_sequence][:cc_all_attributes][:next_sib] += params[:cc_sequence][:cc_all_attributes][:parent_id]    

    respond_to do |format|
      if @cc_sequence.update_attributes(params[:cc_sequence])
        format.html { redirect_to(@cc_sequence, :notice => 'Sequence component was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cc_sequence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cc_sequences/1
  # DELETE /cc_sequences/1.xml
  def destroy
    @cc_sequence = CcSequence.find(params[:id])
    @cc_sequence.destroy

    respond_to do |format|
      format.html { redirect_to(cc_sequences_url) }
      format.xml  { head :ok }
    end
  end
end
