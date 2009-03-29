require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe "tuio objects" do
  before :each do
    setup_server
  end 
  
  it 'should update tracking' do
    pending( "not finished with implementation")
    send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
    
    @server.tuio_objects.size.should == 1
    @server.tuio_objects[49][:class_id].should == 25
  end
  
  it 'should only keep alive the objects the client says are alive' do
    pending( "not finished with implementation")
    
    send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
    send_message( '/tuio/2Dobj', "set", 51, 26, 0.12, 0.50, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
    
    send_message( '/tuio/2Dobj', "alive", 49)
    
    @server.tuio_objects.size.should == 1
  end
  
  it "should call the update hooks" do
    @server.on_object_update do | objects |
      raise "update hook called!"
    end
    
    lambda {
      send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
    }.should raise_error
  end
  
end

describe "tuio_cursors" do
  before :each do
    setup_server
  end
  
  it 'should update tracking' do
    send_message( '/tuio/2Dcur', "set", 22, 0.38, 0.35, 0.0, 0.0, 0.0 )
    
    @server.tuio_cursors.size.should == 1
  end
  
  it 'should update tracking for multiples' do
    send_message( '/tuio/2Dcur', "set", 22, 0.38, 0.35, 0.0, 0.0, 0.0 )
    send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.50, 0.0, 0.0, 0.0 )
    
    
    @server.tuio_cursors.size.should == 2
  end
  
  it 'should only keep alive the cursors the client says are alive' do
    send_message( '/tuio/2Dcur', "set", 22, 0.38, 0.35, 0.0, 0.0, 0.0 )
    send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.50, 0.0, 0.0, 0.0 )
    
    send_message( '/tuio/2Dcur', "alive", 22)
    
    @server.tuio_cursors.size.should == 1
    @server.tuio_cursors[22][:session_id].should == 22
  end
  
  it "should call the update hooks" do
    @server.on_cursor_update do | objects |
      raise "update hook called!"
    end
    
    lambda {
      send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.50, 0.0, 0.0, 0.0 )
    }.should raise_error
  end
end
