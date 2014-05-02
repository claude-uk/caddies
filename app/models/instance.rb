class Instance < ActiveRecord::Base
  attr_accessor :instanceCount, :sequenceCount, :loopCount, :ifthenelseCount, :questionCount, :statementCount, :ccCount
  attr_accessor :qiCount, :categoryCount, :csCount, :mixedrdaCount, :rdtextCount, :rdnumCount, :rddateCount, :rdcodeCount, :codeCount
  attr_accessor :ccRef, :qiRef, :totalElt, :totalRef, :rdcodeRef, :synapticDensity, :codeRef
  attr_accessor :qlist
  #attr_accessor :qgCount, : qgHeaderRef, :instructionCount, :instructionRef
  @@prefix = "pms"
  cattr_reader :prefix
  @@sep = "."
  cattr_reader :sep
  @@just = 6
  cattr_reader :just


  #I need to count the constructs from parent to child from the top sequence as I don't want to include the ones in the attic
  #I don't need to count the construct references separately, as they are all referenced in their parent,
  #including the top_sequence in the instrument
  #the library type elements (question items, categories... are all included)
  def set_statistics
    self.instanceCount = 1

    #count the constructs, no change for ddi3.2
    self.sequenceCount = 0
    self.loopCount = 0
    self.ifthenelseCount = 0
    self.questionCount = 0
    self.statementCount = 0
    @cc_node = CcAll.find(1)		#start with top_sequence
    count_nodes(@cc_node)		#recurse over the constructs
    self.ccCount = self.sequenceCount + self.loopCount + self.ifthenelseCount + self.questionCount + self.statementCount

		#count references in constructs
    self.ccRef = self.ccCount		#reference to a construct in its parent
    self.ccRef += self.loopCount	#to account for the wrapper sequence
    #do I assume that I automatically have the 'else' sequence?
    self.ccRef += 2 * self.ifthenelseCount	#to account for the branch wrapper sequences
    self.qiRef = self.questionCount	#each question construct has a reference to a question item or question grid

    #count the question items and their response domains and instruction refs
    self.qiCount = QuestionItem.count
    self.mixedrdaCount = QiRda.select("question_item_id, count(*)").group("question_item_id").having("count(*) > 1").all.count
    self.rdtextCount = QiRda.includes(:response_domain_all).where("response_domain_alls.domain_type = 'ResponseDomainText'").count
    self.rdnumCount = QiRda.includes(:response_domain_all).where("response_domain_alls.domain_type = 'ResponseDomainNumeric'").count
    self.rddateCount = QiRda.includes(:response_domain_all).where("response_domain_alls.domain_type = 'ResponseDomainDatetime'").count
    self.rdcodeCount = QiRda.includes(:response_domain_all).where("response_domain_alls.domain_type = 'ResponseDomainCode'").count
    self.rdcodeRef = self.rdcodeCount	#each has a ref to a code scheme
    self.instructionRef = QuestionItem.where("instruction_id is not null").count

		#count question grids, their codelists and response domains
		self.qgCount = QuestionGrid.count
		#all grids have a horizontal header codelist but the vertical one is optional
		self.qgHeaderRef = self.qgCount + QuestionGrid.where("vertical_codelist_id is not null").count
    self.instructionRef += QuestionGrid.where("instruction_id is not null").count
    self.qgRdaRef = QgridRda.count
    
		
    #count other items
    self.categoryCount = Category.count
    self.csCount = CodeScheme.count
    self.codeCount = Code.count
    self.codeRef = self.codeCount	#references to categories in codeschemes
    self.instructionCount = Instruction.count

    #add up all the references
    self.totalRef = self.ccRef + self.qiRef + self.rdcodeRef + self.codeRef + self.qgHeaderRef + self.instructionRef
    
    #count xml elements
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

  private
  
    #nb: I don't care in which branch the ifthenelse children are
    def count_nodes(node)
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

#in progress
    #read the xml-based views to get the multipliers
    def apply_multipliers
      #i.e. the number of xml elements
      #top level elements in instance ddi3 xml without the reference to the top sequence
      self.totalElt = 18 * self.instanceCount	#citation (3), resoucePackage (6), datacollection (4),
      self.totalElt += 2 * self.sequenceCount	#d:Sequence, d:ConstructName
      #it includes the 2 elements of the wrapper sequence, but not the reference to it which is counted with the other cc references 
      self.totalElt += 8 * self.loopCount	#d:Loop, d:ConstructName, d:InitialValue, r:Code, d:LoopWhile, r:Code, d:Sequence, d:ConstructName
      #it includes 2 * 2 elements for the wrapper sequences
      self.totalElt += 8 * self.ifthenelseCount	#d:IfThenElse, d:ConstructName, d:IfCondition, r:Code, d:Sequence, d:ConstructName, d:Sequence, d:ConstructName 
      #includes reference to question item
      self.totalElt += 11 * self.questionCount	#d:QuestionConstruct, d:ConstructName, d:QuestionReference, r:Scheme, r:ID, r:IdentifyingAgency, r:Version, r:ID, r:IdentifyingAgency, r:Version, ResponseUnit
      self.totalElt += 5 * self.statementCount	#d:StatementItem, d:ConstructName, d:DisplayText, d:LiteralText, d:Text
      #add the cc references
      self.totalElt += 8 * self.ccRef		#d:ControlConstructReference, r:Scheme, r:ID, r:IdentifyingAgency, r:Version, r:ID, r:IdentifyingAgency,r:Version

      self.totalElt += 2 + (3 * categoryCount)		#l:CategoryScheme, l:CategorySchemeName; l:Category, l:CategoryName, r:Label
      self.totalElt += 2 * csCount		#l:CodeScheme, l:CodeSchemeName
      self.totalElt += 10  * codeCount		#l:Code, l:CategoryReference, r:Scheme, r:ID, r:IdentifyingAgency, r:Version, r:ID, r:IdentifyingAgency, r:Version, l:Value

      #qi without the response domain
      self.totalElt += 2 + (6 * self.qiCount)	#d:QuestionScheme, d:QuestionSchemeName; d:QuestionItem, d:QuestionItemName, d:QuestionText, d:LiteralText, d:Text, d:QuestionIntent
      self.totalElt += self.mixedrdaCount	#d:StructuredMixedResponseDomain
      self.totalElt += 2 * self.rdtextCount	#d:TextDomain, r:Label
      self.totalElt += 5 * self.rdnumCount	#d:NumericDomain, r:NumberRange, r:Low, r:High, d:Label
      self.totalElt += 2 * self.rddateCount	#d:DateTimeDomain, d:Label
      self.totalElt += 5 * self.rdcodeCount	#d:CodeDomain, r:CodeSchemeReference, r:ID, r:IdentifyingAgency, r:Version
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

end
