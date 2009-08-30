# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tuio-ruby}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["aberant"]
  s.date = %q{2009-08-30}
  s.email = %q{qzzzq1@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["examples/tuio_dump.rb", "lib/tuio-ruby", "lib/tuio-ruby/core_ext", "lib/tuio-ruby/core_ext/float.rb", "lib/tuio-ruby/core_ext/object.rb", "lib/tuio-ruby/tuio_client.rb", "lib/tuio-ruby/tuio_container.rb", "lib/tuio-ruby/tuio_cursor.rb", "lib/tuio-ruby/tuio_cursor_parameter.rb", "lib/tuio-ruby/tuio_object.rb", "lib/tuio-ruby/tuio_object_parameter.rb", "lib/tuio-ruby/tuio_parameter.rb", "lib/tuio-ruby/tuio_point.rb", "lib/tuio-ruby.rb", "spec/integration/tuio_event_spec.rb", "spec/spec_helper.rb", "spec/unit/tuio_container_spec.rb", "spec/unit/tuio_cursor_parameter_spec.rb", "spec/unit/tuio_cursor_spec.rb", "spec/unit/tuio_object_parameter_spec.rb", "spec/unit/tuio_object_spec.rb", "spec/unit/tuio_parameter_spec.rb", "spec/unit/tuio_point_spec.rb", "README.rdoc", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/aberant/tuio-ruby}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{library to interface with TUIO protocol}
  s.test_files = ["spec/integration/tuio_event_spec.rb", "spec/spec_helper.rb", "spec/unit/tuio_container_spec.rb", "spec/unit/tuio_cursor_parameter_spec.rb", "spec/unit/tuio_cursor_spec.rb", "spec/unit/tuio_object_parameter_spec.rb", "spec/unit/tuio_object_spec.rb", "spec/unit/tuio_parameter_spec.rb", "spec/unit/tuio_point_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
