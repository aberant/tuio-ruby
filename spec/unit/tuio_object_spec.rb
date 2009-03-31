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
    @to = TuioObject.new( *@args1 )
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
  
  describe "event hooks" do
    
  end
  
  describe "on update" do
    before :each do
      @args2 = [
        @x_pos2 = 0.7,
        @y_pos2 = 0.4,
        @angle2 = 1.1,
        @x_speed = 0.1,
        @y_speed = 0.2,
        @rotation_speed = 0.11,
        @motion_accel = 0.12,
        @rotation_accel = 0.13
      ]
      
      @to.update( *@args2 )
    end
    
    it "should be able to compare it's args" do
      @to.eql?( [
        @session_id,
        @fiducial_id,
        @x_pos2,
        @y_pos2,
        @angle2,
        @x_speed,
        @y_speed,
        @rotation_speed,
        @motion_accel,
        @rotation_accel
      ]).should be_true
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
    
    it "should know it's rotation speed" do
      @to.rotation_speed.should == @rotation_speed
    end
    
    it "should know it's rotation accel" do
      @to.rotation_accel.should == @rotation_accel
    end
  end
end