class CcAll < ActiveRecord::Base
  validate :descendants
  #belongs_to :cc_type
  belongs_to :construct, :polymorphic => true
  belongs_to :parent, :class_name => 'CcAll'
  has_many :children, :class_name => 'CcAll', :foreign_key => 'parent_id', :order => 'position ASC'
  has_many :if_children, :class_name => 'CcAll', :foreign_key => 'parent_id', :order => 'position ASC', :conditions => {:ifbranch => true}
  has_many :else_children, :class_name => 'CcAll', :foreign_key => 'parent_id', :order => 'position ASC', :conditions => {:ifbranch => false}
  accepts_nested_attributes_for :children
  #attr_accessible :children_attributes
  #after_save :generate_position
    

  def descendants
    dnodes = childnodes(self)        
    errors.add(:parent_id, "There is a loop in the chain of constructs " + dnodes.join(", ")) if dnodes.include?(parent_id)
  end
  
  def childnodes(node)
    n = []
    #the childnodes need to include the node itself, to exclude a node having itself as a parent
    if ['CcSequence', 'CcLoop', 'CcIfthenelse'].include?(node.construct_type)
      n.push(node.id)
    end
    node.children.each do |child|
      if ['CcSequence', 'CcLoop', 'CcIfthenelse'].include?(child.construct_type)
        n.push(child.id)
        n.concat(childnodes(child))
      end
    end
    return n
  end
  
  def root_ancestor
    if parent
      parent.root_ancestor
    else
      return id
    end
  end
  
  def add_to_attic
    #I assume that the ccall_id of the attic is 0
    self.parent_id = 0
    values = CcAll.maximum(:position, :group => 'parent_id')
    if values[0]
      last = values[0]
    else
      last = 0
    end    	
    self.position = last + 1
  end
  
#  def id_plus
#    id1 = "#{id}".rjust(2, '.')
#    id2 = "#{construct_type}"
#    id3 = "#{cc_type.id}"
#    id1 + '...' + id2 + '.' + id3
#  end
  
  def id_plus2
    sep = '~'
    id1 = "#{id}".rjust(3, sep)
    id2 = "#{construct_type}".ljust(15, sep)
    id3 = "#{construct.textid}"
    id1 + sep + sep + sep + id2 + sep + id3
  end
  
  def id_if
    "#{id}" + "_1"
  end
  
  def id_else
    "#{id}" + "_0"
  end

  #obsolete
  def children_by_branch(ifbranch)    
    if self.construct_type != 'CcIfthenelse'
      self.children
    else
      if (ifbranch == true)
        self.if_children
      else
        self.else_children
      end
    end
  end
  
  #parent id or 0 if no parent, to provide (initial) sibling options in menus
  #if there are no parent, the attic (id = 0) is assumed
  def initial_parent
    if self.parent
      return self.parent.id
    else
      return 0
    end
  end
  
  #this virtual attribute is used for positions
  #get the next sibling from the position field or nil if it is last
  def next_sib
    if self.parent
      sibs = self.parent.children.order('position ASC')
      sibs.each_with_index do |sib, i|
        if self.id == sib.id
          if i + 1 < sibs.length
            return sibs[i + 1].id
          else		#if last
            return nil
          end
        end
      end
    else		#if has no parent
      return nil
    end
  end
            
  #set the next sibling, ie the underlying positions
  #the argument is a compound argument with underscore and parent id
  #was written for single branch descendants, but works for if and else branches
  def next_sib=(sib_parent)
    attribute_will_change!(:next_sib)	#marks it as dirty, see stackoverflow
    argarray = sib_parent.split('_')
    sib = argarray[0]
    parent = argarray[1]

    sib_ids = []
    sib_positions = []
    self.position = 0	#default if no new parent, no other children, etc
    if !parent.nil?	#if there is a prospective new parent
      #logger.debug("with parent")
      jump = 0
      j = 0	#I need the index outside the loop after all
      CcAll.find(parent).children.each_with_index do |bro,i|
        #logger.debug(bro.to_yaml)
        #logger.debug("bro.id is " + bro.id.to_s())
        #logger.debug("sib is " + sib)
        #logger.debug("sel.id, if it exists, is " + self.id.to_s())
        if bro.id.to_s() == sib		#if bro is the intended next sib, insert
          #logger.debug("push1")
          self.position = i + jump
          jump += 1
        end

        if bro.id == self.id	#if self is an existing child, remove
          #logger.debug("push2")
          jump -= 1
        else			#else add to array
          sib_ids.push(bro.id.to_s())
          hash = {"position" => (i + jump).to_s()}
          sib_positions.push(hash)
          #logger.debug("push3" + hash.to_yaml + "+++" + sib_positions.to_yaml)
        end
        j = i
      end	#end of loop through children
      if sib == ""	#if sib is nil put at the end
        self.position = j + jump + 1
      end
    end		#end of if parent

    #logger.debug "before test update " + sib_ids.length.to_s()
    #CcAll.find(parent).children.update(["247","250"], [{"position" => "300"}, {"position" => "400"}])
    #logger.debug "before update " + sib_positions.to_yaml + "+++"
    CcAll.find(parent).children.update(sib_ids, sib_positions)
  end

end

