require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

# /tuio/2Dobj set s i x y a X Y A m r
# /tuio/2Dcur set s x y X Y m

# session_id, x, y, X, Y, m
shared_examples_for "TuioParameter" do
  
  it "should fetch session id" do
    @tuio_param.session_id.should == @session_id
  end
  
  it "should fetch x position" do
    @tuio_param.x_pos.should == @x_pos
  end
  
  it "should fetch y position" do
    @tuio_param.y_pos.should == @y_pos
  end
  
  it "should fetch x speed" do
    @tuio_param.x_speed.should == @x_speed
  end
  
  it "should fetch y speed" do
    @tuio_param.y_speed.should == @y_speed
  end
  
  it "should fetch motion acceleration" do
    @tuio_param.motion_accel.should == @motion_accel
  end
end