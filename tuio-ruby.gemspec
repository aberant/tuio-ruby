# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tuio-ruby}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["aberant"]
  s.date = %q{2009-04-09}
  s.email = %q{qzzzq1@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/core_ext", "lib/core_ext/float.rb", "lib/core_ext/object.rb", "lib/my_environment.rb", "lib/tuio_client.rb", "lib/tuio_container.rb", "lib/tuio_cursor.rb", "lib/tuio_cursor_parameter.rb", "lib/tuio_object.rb", "lib/tuio_object_parameter.rb", "lib/tuio_parameter.rb", "lib/tuio_point.rb", "spec/integration", "spec/integration/tuio_event_spec.rb", "spec/spec_helper.rb", "spec/unit", "spec/unit/tuio_container_spec.rb", "spec/unit/tuio_cursor_parameter_spec.rb", "spec/unit/tuio_cursor_spec.rb", "spec/unit/tuio_object_parameter_spec.rb", "spec/unit/tuio_object_spec.rb", "spec/unit/tuio_parameter_spec.rb", "spec/unit/tuio_point_spec.rb", "LICENSE"]
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
