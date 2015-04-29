class Instance < ActiveRecord::Base
  #future proofing: I use class variables for what would be valid for any instance of ddiInstance and instance variables for the rest
  attr_accessor :instanceCount, :sequenceCount, :loopCount, :ifthenelseCount, :questionCount, :statementCount, :ccCount
  attr_accessor :qiCount, :categoryCount, :csCount, :singlerdaCount, :mixedrdaCount, :inMixedrdaCount, :rdtextRef, :rdnumRef, :rddateRef, :rdcodeCount, :codeCount
  attr_accessor :ccRef, :qiRef, :totalElt, :totalRef, :rdcodeRef, :synapticDensity, :codeRef
  attr_accessor :qlist
  attr_accessor :slist
  attr_accessor :rdCount, :qgrdCount, :qgCount, :qgHeaderCount, :qgHeaderRef, :rosterCount, :instructionCount, :instructionRef, :qgMixedrdaCount
  attr_accessor :repTextCount, :repNumCount, :repDTCount, :qgMixedrdaCount, :qgInMixedrdaCount, :qgSinglerdaCount, :rdRef
  #@@prefix = "pms"
  #cattr_reader :prefix
  @@sep = "-"
  cattr_reader :sep
  @@just = 6
  cattr_reader :just

	include SharedMethods
  @@type_prefix = "ddi"
  cattr_reader :type_prefix
	#the ddi instance,most schemes and the instrument have a single id = 1 which is re-used
  @@scheme_id = 1
  @@qitem_scheme_id = 1
  @@qgrid_scheme_id = 2
  @@mrt_scheme_id = 1
  @@mrn_scheme_id = 2
  @@mrd_scheme_id = 3
  cattr_reader :scheme_id, :qitem_scheme_id, :qgrid_scheme_id, :mrt_scheme_id, :mrn_scheme_id, :mrd_scheme_id
  @@category_scheme_prefix = "cas"
  @@resource_package_prefix = "rp"
  @@data_collection_prefix = "dc"
  @@control_construct_scheme_prefix = "ccs"
  @@instrument_scheme_prefix = "ins"
  @@instrument_prefix = "in"
  @@interviewer_instruction_scheme_prefix = "iis"
  @@managed_representation_scheme_prefix = "mrs"
  @@code_list_scheme_prefix = "cos"
  @@question_scheme_prefix = "qs"
  cattr_reader :category_scheme_prefix, :resource_package_prefix, :data_collection_prefix, :control_construct_scheme_prefix, :instrument_scheme_prefix, :instrument_prefix
  cattr_reader :interviewer_instruction_scheme_prefix, :code_list_scheme_prefix, :question_scheme_prefix 
  cattr_reader :managed_representation_scheme_prefix


  #the stats correspond to the ddi3.2 output in library mode
  #I need to count the constructs from parent to child from the top sequence as I don't want to include the ones in the attic
  #the library type elements (question items, categories... are all included)
  #the wrapper sequences are included in the total count
  def set_statistics
    self.instanceCount = 1
    count_constructs
    count_library_items
    count_optional_items
    count_references
    #get total of elements
    apply_multipliers
    #final calculations
    self.synapticDensity = 100.0 * self.totalRef / self.totalElt
  end

  
  #extract the name of the question constructs in the order of the cc scheme (for the data mapping file)
  def set_qlist()
    self.qlist = []
    @cc_node = CcAll.find(1)		#start with top_sequence
    collect_questions(@cc_node)		#recurse over the constructs
  end

  #extract the name of the sequences in the order of the cc scheme (for the data mapping file)
  def set_slist()
    self.slist = []
    @cc_node = CcAll.find(1)		#start with top_sequence
    collect_sequences(@cc_node)		#recurse over the constructs
  end

  private
  
  	def count_constructs
	    #count the constructs, typed constructs are the visible ones only
	    #total ccCount includes the wrapper ones, I assume that ifthenelse has both branches
	    self.sequenceCount = 0
	    self.loopCount = 0
	    self.ifthenelseCount = 0
	    self.questionCount = 0
	    self.statementCount = 0
	    @cc_node = CcAll.find(1)		#start with top_sequence
	    count_nodes(@cc_node)		#recurse over the constructs
    	self.ccCount = self.sequenceCount + 2 * self.loopCount + 3 * self.ifthenelseCount + self.questionCount + self.statementCount
  	end
  
    def count_nodes(node)
    	#nb: I don't care in which branch the ifthenelse children are
      if node.construct_type == 'CcSequence'
        self.sequenceCount += 1  
        node.children.each do |cc_child|
          count_nodes(cc_child)
        end
      elsif node.construct_type == 'CcLoop'
        self.loopCount += 1  
        node.children.each do |cc_child|
          count_nodes(cc_child)
        end
      elsif node.construct_type == 'CcIfthenelse'
        self.ifthenelseCount += 1  
        node.children.each do |cc_child|
          count_nodes(cc_child)
        end
      elsif node.construct_type == 'CcStatement'
        self.statementCount += 1  
      elsif node.construct_type == 'CcQuestion'
        self.questionCount += 1  
      end
    end

		def count_library_items
			#questions
    	self.qiCount = QuestionItem.count
			self.qgCount = QuestionGrid.count
			#managed representations
			self.repTextCount = ResponseDomainText.count
			self.repNumCount = ResponseDomainNumeric.count
			self.repDTCount = ResponseDomainDatetime.count
    	#count other items
    	self.categoryCount = Category.count
    	self.csCount = CodeScheme.count
    	self.codeCount = Code.count
    	self.instructionCount = Instruction.count
		end
		
		#count items that are not always present or in varied formats 
		def count_optional_items
			#count the single and mixed response domains
    	self.rdCount = QiRda.count
    	self.singlerdaCount = QiRda.select("question_item_id, count(*)").group("question_item_id").having("count(*) = 1").all.count
    	self.mixedrdaCount = QiRda.select("question_item_id, count(*)").group("question_item_id").having("count(*) > 1").all.count
			self.inMixedrdaCount = self.rdCount - self.singlerdaCount
			#for grids
    	self.qgSinglerdaCount, qgDuprdaCount, qgDupcoderdaCount = QuestionGrid.all_with_single_rd_count
    	self.qgMixedrdaCount = QuestionGrid.all_with_mixed_rd_count
    	self.qgrdCount = QgridRda.where("response_domain_all_id is not null").count - qgDuprdaCount
			self.qgInMixedrdaCount = self.qgrdCount - self.qgSinglerdaCount
    	#count the code response domains as they have an additional element 'codedomain' wrapping the reference
    	self.rdcodeCount = QiRda.includes(:response_domain_all).where("response_domain_alls.domain_type = 'ResponseDomainCode'").count
    	self.rdcodeCount += QgridRda.includes(:response_domain_all).where("response_domain_alls.domain_type = 'ResponseDomainCode'").count - qgDupcoderdaCount
			#all grids have a horizontal header codelist but the vertical one is optional, counted for 'codedomain'
			self.qgHeaderCount = self.qgCount + QuestionGrid.where("vertical_codelist_id is not null").count
			self.rosterCount = QuestionGrid.where("vertical_roster_rows != 0").count
		end
		
		def count_references
    	self.ccRef = self.ccCount		#reference to a construct in its parent
    	self.qiRef = self.questionCount	#each question construct has a reference to a question item or question grid
    	self.codeRef = self.codeCount	#references to categories in codeslists
    	self.instructionRef = QuestionItem.where("instruction_id is not null").count
    	self.instructionRef += QuestionGrid.where("instruction_id is not null").count
    	self.qgHeaderRef = self.qgHeaderCount
    	self.rdRef = self.rdCount + self.qgrdCount
    	#add up all the references
	    self.totalRef = self.ccRef + self.qiRef + self.codeRef + self.instructionRef + self.qgHeaderRef + self.rdRef
		end

    #count the number of xml elements, for help read the xml-based views to get the multipliers
    def apply_multipliers
    	#debugger
    	#the references are counted separately
      #top level elements in instance ddi3 xml without the reference to the top sequence
      self.totalElt = 29 * self.instanceCount	#instance,urn,citation,title,string,subtitle,string,rp,urn,citation,title,string,purpose,content,dc,urn,dcmname,string,ccscheme,urn,ccsname,ischeme,urn,isname,string,instrument,urn,iname,string
      self.totalElt += 4 * self.sequenceCount	#d:Sequence,urn,cname,string
      #it includes the 4 elements of the wrapper sequence, but not the reference to it which is counted with the other cc references 
      self.totalElt += 16 * self.loopCount	#Loop,urn,ConstructName,string,InitialValue,Command,planguage,pcontent,LoopWhile,Command,planguage,pcontent,Sequence,urn,ConstructName,string
      #it includes 2 * 4 elements for the wrapper sequences
      self.totalElt += 16 * self.ifthenelseCount	#IfThenElse,urn,ConstructName,string,IfCondition,Command,planguage,pcontent,Sequence,urn,ConstructName,string,Sequence,urn,ConstructName,string 
      #excludes reference to question item or grid
      self.totalElt += 5 * self.questionCount	#QuestionConstruct,urn,ConstructName,string,ResponseUnit
      self.totalElt += 7 * self.statementCount	#StatementItem,urn,ConstructName,string,DisplayText,LiteralText,Text

      self.totalElt += 4 + (6 * categoryCount)		#CategoryScheme,urn,CategorySchemeName,string; Category,urn,CategoryName,string,Label,content
      self.totalElt += 4 + (4 * csCount)		#CodeListScheme,urn,CodeSchemeName,string; codelist,urn,label,content
      self.totalElt += 2  * codeCount		#Code,Value

      #qi without the response domain and without interviewer inst ref
      self.totalElt += 4 + (9 * self.qiCount)	#QuestionScheme,urn,QuestionSchemeName,string; QuestionItem,urn,QuestionItemName,string,QuestionText,LiteralText,Text,QuestionIntent,content
			#qg without code domain, roster, response domain or interviewer inst ref
      self.totalElt += 4 + (11 * self.qgCount)	#QuestionScheme,urn,QuestionSchemeName,string; Questiongrid,urn,QuestionGridName,string,QuestionText,LiteralText,Text,QuestionIntent,content, griddimension1,griddimension2
			#qi and qg mixed rd
			self.totalElt += self.mixedrdaCount		#structuredmixedresponsedomain
			self.totalElt += self.qgMixedrdaCount		#structuredmixedgridresponsedomain
			self.totalElt += self.inMixedrdaCount		#responsedomaininmixed
			self.totalElt += 5 * self.qgInMixedrdaCount		#gridresponsedomain, gridattachment,cellcoordinatesasdefined,selectdimension1, selectdimension2
			#code domain
			self.totalElt += self.rdcodeCount			#codedomain
			#roster
			self.totalElt += 3 * self.rosterCount	#roster,labelcontent
			#header code domain
			self.totalElt += self.qgHeaderCount		#codedomain
			
			#managed representations and instructions
			self.totalElt += 4 + (4 * repTextCount)
			self.totalElt += 4 + (8 * repNumCount)
			self.totalElt += 4 + (6 * repDTCount)
			self.totalElt += 4 + (5 * instructionCount)
			
      #add all references
      self.totalElt += 3 * self.totalRef		#Reference,urn,typeofobject
    end

        
    def collect_questions(node)
      if ['CcSequence', 'CcLoop', 'CcIfthenelse'].include?(node.construct_type)
        node.children.each do |cc_child|
          collect_questions(cc_child)
        end
      elsif node.construct_type == 'CcQuestion'
        self.qlist.push("|" + node.construct.textid + "|" + node.construct.question_reference.intent.squish + "|" + node.construct.question_reference.literal.squish) 
      end
    end

    def collect_sequences(node)
      if ['CcSequence', 'CcLoop', 'CcIfthenelse'].include?(node.construct_type)
      	if node.construct_type == 'CcSequence'
        	self.slist.push(node.construct.urn_id + "|" + node.construct.textid.squish) 
        end	
        node.children.each do |cc_child|
          collect_sequences(cc_child)
        end
      end
    end

end
