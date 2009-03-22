# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tuio-ruby}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["aberant"]
  s.date = %q{2009-03-22}
  s.email = %q{qzzzq1@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/tuio_client.rb", "spec/spec_helper.rb", "spec/tuio_event_spec.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/aberant/tuio-ruby}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{inital gem}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
