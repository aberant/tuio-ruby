require 'rubygems'
require 'spec'
require 'osc-ruby'

$: << File.join( File.dirname( __FILE__ ), '..', 'lib' )

require 'tuio-ruby'

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
  socket = mock( "socket" )

  # stub out networking
  socket.stub!(:bind).with("", 3333)

  UDPSocket.stub!(:new).and_return( socket )

  # UDPSocket.new.bind( "", 3333 )
  @server = TuioClient.new
end