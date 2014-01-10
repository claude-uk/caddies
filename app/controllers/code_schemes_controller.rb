class CodeSchemesController < ApplicationController
  # GET /code_schemes
  # GET /code_schemes.xml
  def index
    @code_schemes = CodeScheme.includes(:response_domain_codes).all
    @instance = Instance.find(1)

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @code_schemes }
      format.xml # index.xml.erb
    end
  end

  # GET /code_schemes/1
  # GET /code_schemes/1.xml
  def show
    @code_scheme = CodeScheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @code_scheme }
    end
  end

  # GET /code_schemes/new
  # GET /code_schemes/new.xml
  def new
    @code_scheme = CodeScheme.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @code_scheme }
    end
  end

  # GET /code_schemes/1/edit
  def edit
    @code_scheme = CodeScheme.find(params[:id])
  end

  # POST /code_schemes
  # POST /code_schemes.xml
  def create
     #I don't know how to deserialize, do it manually
     #params[:code_scheme] << {:codes_attributes => [{:category_id => 3, :cs_value => 20, :cs_order => 1}]}
     #params = {:code_scheme => {:label => 'dummy01', :codes_attributes => [{:category_id => 3, :cs_value => 20, :cs_order => 1}]}}
     #params[:code_scheme] = {:label => 'dummy01', :codes_attributes => [{:category_id => 3, :cs_value => 20, :cs_order => 1}]}
     #params[:code_scheme][:codes_attributes] = [{:category_id => 3, :cs_value => 20, :cs_order => 1}, {:category_id => 4, :cs_value => 40, :cs_order => 2}]
     #params[:temp] = params[:code_table].split('&')
     #params[:temp] = []
     params[:code_scheme][:codes_attributes] = []
     rows = params[:code_table].split('&')
     rows.each_with_index do |row, index|
       tmp, row = row.split('=')
       val, cat = row.split('+')
       params[:code_scheme][:codes_attributes] << {:category_id => cat, :cs_value => val, :cs_order => index + 1}
     end
     
#   render :text => params.inspect
    @code_scheme = CodeScheme.new(params[:code_scheme])

    respond_to do |format|
      if @code_scheme.save
        format.html { redirect_to(@code_scheme, :notice => 'Code scheme was successfully created.') }
        format.xml  { render :xml => @code_scheme, :status => :created, :location => @code_scheme }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @code_scheme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /code_schemes/1
  # PUT /code_schemes/1.xml
  def update
     params[:code_scheme][:codes_attributes] = []
     rows = params[:code_table].split('&')
     rows.each_with_index do |row, index|
       tmp, row = row.split('=')
       val, cat, id = row.split('+')
        row_hash = {:category_id => cat, :cs_value => val, :cs_order => index + 1}
        if id
          row_hash[:id] = id
        end
       params[:code_scheme][:codes_attributes] << row_hash
     end
     #do deletables
     rows = params[:deletables].split(',')
     rows.each do |row|
       row_hash = {:id => row, :_destroy => '1' }
       params[:code_scheme][:codes_attributes] << row_hash
     end     
#     render :text => params.inspect

    @code_scheme = CodeScheme.find(params[:id])

    respond_to do |format|
      if @code_scheme.update_attributes(params[:code_scheme])
        format.html { redirect_to(@code_scheme, :notice => 'Code scheme was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @code_scheme.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /code_schemes/1
  # DELETE /code_schemes/1.xml
  def destroy
    @code_scheme = CodeScheme.find(params[:id])
    @code_scheme.destroy

    respond_to do |format|
      format.html { redirect_to(code_schemes_url) }
      format.xml  { head :ok }
    end
  end
end
