require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe TuioCursor do
  before :each do
    @args1 = [
      @session_id = 42,
      @x_pos = 0.8,
      @y_pos = 0.4,
    ]
    @params = TuioCursorParameter.from_creation_args( *@args1 )
    @tc = TuioCursor.from_params( @params )
  end
  
  describe "update" do
    before :each do
      @args2 = [
        @session_id = 42,
        @x_pos2 = 0.23,
        @y_pos2 = 0.54,
        @x_speed = 0.01,
        @y_speed = 0.03,
        @motion_accel = 0.02
      ]
      @update_params = TuioCursorParameter.from_update_args( *@args2 )
      @tc.update_from_params( @update_params )
    end
    
    it "should it is equal to some arguments" do
      @tc.params_equal?( @update_params )
    end
  end
end
