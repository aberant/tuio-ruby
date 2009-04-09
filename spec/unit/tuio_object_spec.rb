require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe TuioObject do
  before :each do
    @args1 = [
      @session_id = 42,
      @fiducial_id = 1,
      @x_pos = 0.8,
      @y_pos = 0.4,
      @angle = 1
    ]
    @params = TuioObjectParameter.from_creation_args( *@args1 )
    @to = TuioObject.from_params( @params )
  end
  
  describe "in general" do
    it "should know it's session id" do
      @to.session_id.should == @session_id
    end
    
    it "should know it's fiducial id" do
      @to.fiducial_id.should == @fiducial_id
    end
    
    it "should know it's x position" do
      @to.x_pos.should == @x_pos
    end
    
    it "should know it's y postion" do
      @to.y_pos.should == @y_pos
    end
    
    it "should know it's angle" do
      @to.angle.should == @angle
    end
  end
  
  describe "on update" do
    
    before :each do
      @args2 = [
        @sesssion_id = 42,
        @fiducial_id = 1,
        @x_pos2 = 0.7,
        @y_pos2 = 0.4,
        @angle2 = 1.1,
        @x_speed = 0.1,
        @y_speed = 0.2,
        @rotation_vector = 0.11,
        @motion_accel = 0.12,
        @rotation_accel = 0.13
      ]
      @update_params = TuioObjectParameter.new( *@args2 )
      @to.update_from_params( @update_params )
    end
    
    it "should be able to compare it's args" do
      @to.params_equal?( @update_params ).should be_true
    end
    
    it "should know it's new x position" do
      @to.x_pos.should == @x_pos2
    end
    
    it "should know it's new y position" do
      @to.y_pos.should == @y_pos2
    end
    
    it "should know it's new angle" do
      @to.angle.should == @angle2
    end
    
    it "should know it's x speed" do
      @to.x_speed.should == @x_speed
    end
    
    it "should know it's y speed" do
      @to.y_speed.should == @y_speed
    end
    
    it "should know it's rotation vector" do
      @to.rotation_vector.should == @rotation_vector
    end
    
    it "should know it's rotation accel" do
      @to.rotation_accel.should == @rotation_accel
    end
  end
end