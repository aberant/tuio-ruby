require 'spec/rake/spectask'


task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.warning = false
  t.rcov = false
  t.spec_opts = ["--colour"]#, "--diff"]
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "tuio-ruby"
    gem.summary = %Q{library to interface with TUIO protocol}
    gem.email = "qzzzq1@gmail.com"
    gem.homepage = "http://github.com/aberant/tuio-ruby"
    gem.authors = ["aberant"]
    gem.files = FileList['Rakefile', 'examples/**/*', 'lib/**/*'].to_a
    gem.test_files = FileList['spec/**/*.rb']
    gem.add_dependency('aberant-osc-ruby', '>= 0.1.6')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end