require 'erb'

TEMPLATE_FILE='app\views\instances\stats.csv.erb'

def get_template
  File.read(TEMPLATE_FILE)
end

namespace :ddistats do

# "Assignments that are in the caddies controllers"
task :controller_variables do
  @instance = Instance.first
  @instance.set_statistics
end

desc "output stats, using ERB."
task :stats => [:environment, :controller_variables] do
   puts ERB.new(get_template).result()
end

task :default => :stats

end