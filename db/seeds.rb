# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

#in the gui replace xxx with a dataset-specific string.
Instance.delete_all
instance = Instance.create!(:agency => 'cls',
:version => '1.0.0',
:instance => 'xxx_inst01',
:inst_citation => 'xxx instance 01',
:resource_package => 'xxx_rp01',
:rp_citation => 'xxx resource package 01',
:purpose => 'xxx_p01',
:purpose_text => 'not specified',
:cc_scheme => 'xxx_ccs01',
:category_scheme => 'xxx_cs01',
:question_scheme => 'xxx_qs01',
:ddata_collection => 'xxx_ddc01',
:instrument => 'xxx_instr01',
:top_sequence => 'TopSequence')


#add the control construct types
#CcType.delete_all
#cc_types = CcType.create!([{:id => 1, :label => 'sequence'},
#				{:id => 2, :label => 'ifthenelse'},
#				{:id => 3, :label => 'repeatuntil'},
#				{:id => 4, :label => 'repeatwhile'},
#				{:id => 5, :label => 'loop'},
#				{:id => 6, :label => 'computationitem'},
#				{:id => 7, :label => 'statementitem'},
#				{:id => 8, :label => 'questionconstruct'}])


#add the response domain types
ResponseDomainType.delete_all
response_domain_types = ResponseDomainType.create!([{:id => 1, :label => 'text'},
						{:id => 2, :label => 'numeric'},
						{:id => 3, :label => 'code'},
						{:id => 4, :label => 'datetime'}])

#add the numeric types
NumericType.delete_all
numeric_types = NumericType.create!([{:id => 1, :label => 'Integer'},
						{:id => 2, :label => 'Float'}])

#add the datetime types
DatetimeType.delete_all
datetime_types = DatetimeType.create!([{:id => 1, :label => 'Date'},
						{:id => 2, :label => 'Time'},
						{:id => 3, :label => 'Duration'}])

#add starter sequences and hook them to the top of the spine, ie without a parent
#the attic is the scratchpad, can't add it here because I want id = 0
CcSequence.delete_all
cc_sequences = CcSequence.create!(:textid => 'TopSequence')	#:id => 1			

#CcAll is not needed is created automatically by the model with parent = nil
