require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"



task :default => :package do
  puts "Don't forget to write some tests!"
end

# This builds the actual gem. For details of what all these options
# mean, and other ones you can add, check the documentation here:
#
#   http://rubygems.org/read/chapter/20
#
spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "floehopper-deploy"
  s.version           = "0.1.4"
  s.summary           = "Makes deploying my apps much simpler"
  s.author            = "James Mead"
  s.email             = "james@floehopper.org"
  s.homepage          = "http://jamesmead.org"

  s.has_rdoc          = true
  # You should probably have a README of some kind. Change the filename
  # as appropriate
  # s.extra_rdoc_files  = %w(README)
  # s.rdoc_options      = %w(--main README)

  # Add any extra files to include in the gem (like your README)
  s.files             = %w(Gemfile) + Dir.glob("{lib/**/*}") + Dir.glob("{puppet/**/*}")
  s.require_paths     = ["lib"]

  # If you want to depend on other gems, add them here, along with any
  # relevant versions
  s.add_dependency("freerange-deploy")
  s.add_dependency("freerange-puppet")

  # If your tests use any gems, include them here
  # s.add_development_dependency("mocha") # for example
end

# This task actually builds the gem. We also regenerate a static
# .gemspec file, which is useful if something (i.e. GitHub) will
# be automatically building a gem for this project. If you're not
# using GitHub, edit as appropriate.
#
# To publish your gem online, install the 'gemcutter' gem; Read more 
# about that here: http://gemcutter.org/pages/gem_docs
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

task :package => :gemspec

# Generate documentation
Rake::RDocTask.new do |rd|
  
  rd.rdoc_files.include("lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end

desc 'Tag the repository in git with gem version number'
task :tag => [:gemspec, :package] do
  if `git diff --cached`.empty?
    if `git tag`.split("\n").include?("v#{spec.version}")
      raise "Version #{spec.version} has already been released"
    end
    `git add #{File.expand_path("../#{spec.name}.gemspec", __FILE__)}`
    `git commit -m "Released version #{spec.version}"`
    `git tag v#{spec.version}`
    `git push --tags`
    `git push`
  else
    raise "Unstaged changes still waiting to be committed"
  end
end

desc "Tag and publish the gem to rubygems.org"
task :publish => :tag do
  `gem push pkg/#{spec.name}-#{spec.version}.gem`
end