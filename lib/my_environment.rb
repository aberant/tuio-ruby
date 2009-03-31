$: << File.dirname( __FILE__ )

%w{ point container object }.each do | type |
  require "tuio_#{type}"
end