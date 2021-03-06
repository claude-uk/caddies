desc "Update the database instance table for 0.12.1"
task :update_instance => :environment do
  instance = Instance.find(1)
  instance.agency = "uk.cls"
  instance.version = "1.0.0"
  instance.prefix = "#{RAILS_ENV}"
  instance.inst_citation = "#{RAILS_ENV} instance 01"
  instance.rp_citation = "#{RAILS_ENV} resource package 01"
  instance.instrument_scheme = "#{RAILS_ENV}_is01"
  instance.purpose_text = "not specified"
  instance.cc_scheme = "#{RAILS_ENV}_ccs01"
  instance.category_scheme = "#{RAILS_ENV}_cs01"
  instance.question_scheme = "#{RAILS_ENV}_qs01"
  instance.ddata_collection = "#{RAILS_ENV}_ddc01"
  instance.instrument = "#{RAILS_ENV}_instr01"
  instance.top_sequence = "TopSequence"
  instance.question_grid_scheme = "#{RAILS_ENV}_qgs01"
  instance.instruction_scheme = "#{RAILS_ENV}_is01"
  instance.code_list_scheme = "#{RAILS_ENV}_cos01"
  instance.mrep_text_scheme = "#{RAILS_ENV}_mrst01"
  instance.mrep_num_scheme = "#{RAILS_ENV}_mrsn01"
  instance.mrep_dt_scheme = "#{RAILS_ENV}_mrsd01"
  instance.save!
  puts "update db #{RAILS_ENV} done"
end