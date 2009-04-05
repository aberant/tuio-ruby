require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe TuioCursor do
  before :each do
    @args1 = [
      @session_id = 42,
      @x_pos = 0.8,
      @y_pos = 0.4,
    ]
    @tc = TuioCursor.new( *@args1 )
  end
  
  describe "update" do
    before :each do
      @args2 = [
        @x_pos2 = 0.23,
        @y_pos2 = 0.54,
        @x_speed = 0.01,
        @y_speed = 0.03,
        @motion_accel = 0.02
      ]
      @tc.update( *@args2 )
    end
    
    it "should it is equal to some arguments" do
      @tc.args_equal?( [@session_id, @x_pos, @y_pos] )
    end
  end
end
