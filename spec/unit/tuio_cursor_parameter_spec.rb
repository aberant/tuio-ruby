require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )
require File.join( File.dirname(__FILE__) , 'tuio_parameter_spec' )

# /tuio/2Dcur set s x y X Y m

describe TuioObjectParameter do
  describe "cursor creation" do
    before :each  do
      args = [  @session_id = 12,
                @x_pos = 0.1,
                @y_pos = 0.2]

      @tuio_param = TuioCursorParameter.new_from_initial_params( *args )
    end
    it "should have propper values set" do
      @tuio_param.session_id == @session_id
      @tuio_param.x_pos == @x_pos
      @tuio_param.y_pos == @y_pos
    end
  end
  
  describe "in general" do
    before :each  do
      args = [
        @session_id = 12,
        @x_pos = 0.1,
        @y_pos = 0.2,
        @x_speed = 0.01,
        @y_speed = 0.02,
        @motion_accel = 0.03,
      ]
    
      @tuio_param = TuioCursorParameter.new( *args )
    end
    
    it_should_behave_like "TuioParameter"
  end
  
end