require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )
require File.join( File.dirname(__FILE__) , 'tuio_parameter_spec' )

# /tuio/2Dobj set s i x y a X Y A m r
# /tuio/2Dcur set s x y X Y m
#def initialize( session_id, fiducial_id, x_pos, y_pos, angle, 
#  x_speed, y_speed, rotation_vector, motion_accel, rotation_accel )

describe TuioObjectParameter do
  
  before :each  do
    args = [
      @session_id = 12,
      @fiducial_id = 41,
      @x_pos = 0.1,
      @y_pos = 0.2,
      @angle = 3,
      @x_speed = 0.01,
      @y_speed = 0.02,
      @rotation_vector = 0.4,
      @motion_accel = 0.03,
      @rotation_accel = 0.02
    ]
    
    @tuio_param = TuioObjectParameter.new( *args )
  end
  
  it_should_behave_like "TuioParameter"
  
  it "should fetch angle" do
    @tuio_param.angle.should == @angle
  end

  it "should fetch rotation vector" do
    @tuio_param.rotation_vector.should == @rotation_vector
  end
  
  it "should fetch rotation acceleration" do
    @tuio_param.rotation_accel.should == @rotation_accel
  end
end