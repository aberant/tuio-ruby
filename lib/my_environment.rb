$: << File.dirname( __FILE__ )
$: << File.join( File.dirname(__FILE__), 'core_ext' )

require 'float'

%w{ point container object }.each do | type |
  require "tuio_#{type}"
end

