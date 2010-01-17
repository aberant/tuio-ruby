require 'spec/rake/spectask'


task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.ruby_opts = ["-rubygems"]
  t.libs << 'lib'
  t.warning = false
  t.rcov = false
  t.spec_opts = ["--colour"]
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "tuio-ruby #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
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
    gem.add_dependency('osc-ruby', '>= 0.1.6')
    gem.rubyforge_project = "tuio-ruby"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end