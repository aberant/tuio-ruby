require 'rubygems'
require 'spec'
require 'rr'
require 'osc'

$: << File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'tuio-ruby' 

Spec::Runner.configure do |config|
    config.mock_with RR::Adapters::Rspec
end

# monkey patch to get at osc core to send messages
class TuioClient
  def osc
    @osc
  end
end

# helper method for integration tests
def send_message( pattern, *msg )
  osc_msg = OSC::Message.new( pattern, nil, *msg)
  
  @server.osc.send( :sendmesg, osc_msg )
end

def setup_server
  mock( socket = Object.new )

  # stub out networking
  stub(socket).bind("", 3333)
  stub(UDPSocket).new { socket }

  @server = TuioClient.new
end