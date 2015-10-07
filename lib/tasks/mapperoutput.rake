namespace :mapper do

desc "Output mapper data from the environment"
task :output_mapper => [:environment] do
  @instance = Instance.first
  @instance.set_mapper()
  puts @instance.mapper.join("\n")
end

task :default => [:output_mapper]

end