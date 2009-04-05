require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe "tuio object" do
  before :each do
    setup_server
  end 
  
  describe "in general" do
    it "should call the creation hook" do
      @server.on_object_creation do | object |
        raise "creation hook called!" if object.session_id == 49
      end
    
      lambda {
        send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
      }.should raise_error
      
      lambda {
        send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
      }.should_not raise_error
    end
    
    it "should call the update hook when session_id is set again with different location" do
      @server.on_object_update do | object |
        raise "update hook called!" if object.session_id == 49
      end

      lambda {
        # this one calls the create hook
        send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
        send_message( '/tuio/2Dobj', "alive", 49)
        
        #this one is the same as before, so nothing to update
        send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
        send_message( '/tuio/2Dobj', "alive", 49)
      }.should_not raise_error
      
      
      lambda {
        #this one calls the update hook
        send_message( '/tuio/2Dobj', "set", 49, 25, 0.12, 0.12, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
        send_message( '/tuio/2Dobj', "alive", 49)
        
      }.should raise_error
    end
    
    it "should call the removal hook when an object is not on the alive list" do
      @server.on_object_removal do | object |
        raise "removal hook called!" if object.session_id == 51
      end
      
      send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
      send_message( '/tuio/2Dobj', "set", 51, 26, 0.12, 0.50, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )

      lambda {
        send_message( '/tuio/2Dobj', "alive", 49)
      }.should raise_error
      
    end
  end
  
  describe "receiving message" do
    before :each do
      send_message( '/tuio/2Dobj', "set", 49, 25, 0.38, 0.35, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
    end
    
    describe "set" do
      it 'should update tracking' do
        @server.tuio_objects.size.should == 1
        @server.tuio_objects[49].fiducial_id.should == 25
      end
    end
  
    describe "alive" do
      it 'should only keep alive the objects the client says are alive' do    
        send_message( '/tuio/2Dobj', "set", 51, 26, 0.12, 0.50, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
        send_message( '/tuio/2Dobj', "alive", 49)

        @server.tuio_objects.size.should == 1
      end
    end
    
    describe "fseq" do
      it "should probably have a test!"
    end
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
    @server.tuio_cursors[22].session_id.should == 22
  end
  
  it "should call the creation hooks" do
    @server.on_cursor_creation do | objects |
      raise "create! hook called!"
    end
    
    lambda {
      send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.50, 0.0, 0.0, 0.0 )
    }.should raise_error
  end
  
  it "should call the update hooks" do
    @server.on_cursor_update do | objects |
      raise "update hook called!"
    end

    lambda {
      send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.50, 0.0, 0.0, 0.0 )
      send_message( '/tuio/2Dcur', "alive", 27)
      
      send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.50, 0.0, 0.0, 0.0 )
      send_message( '/tuio/2Dcur', "alive", 27)
      
    }.should_not raise_error
    
    lambda {
      send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.32, 0.0, 0.0, 0.0 )
      send_message( '/tuio/2Dcur', "alive", 27)
      
    }.should raise_error
    
  end
  
  it "should call the removal hooks" do
    @server.on_cursor_removal do | objects |
      raise "removal hook called!"
    end
    
    lambda {
      send_message( '/tuio/2Dcur', "set", 27, 0.12, 0.50, 0.0, 0.0, 0.0 )
      send_message( '/tuio/2Dcur', "set", 32, 0.18, 0.98, 0.0, 0.0, 0.0 )
    }.should_not raise_error

    lambda {
      send_message( '/tuio/2Dcur', "alive", 27)
      
    }.should raise_error
  end
end
