require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe TuioPoint do
  before :each do
    @location1 = [0.1, 0.1]
    @location2 = [0.1, 0.21]
    
    @point1 = TuioPoint.new( *@location1 )
    @point2 = TuioPoint.new( *@location2 )
  end
  
  describe "in general" do
    it "should know the distance to another point" do
      # not a wonderful test, but a sanity check
      @point1.distance_to( @point2 ).should be_close( 0.11, 0.00001 )
    end
  
    it "should know the angle to another point" do
      # not a wonderful test, but a sanity check
      @point1.radians_to( @point2 ).should be_close( 1.5707963, 0.00001 )
    end
  
    it "should know when it was last updated" do
      @point1.should respond_to(:updated_at)
    end
  end
  
  describe "updates" do
    before :each do
      @point1.updated_at = Time.now
      
      @point1.update( *@location2 )
    end
    
    it "should clear the updated at time" do
      @point1.updated_at.should == nil
    end
  end
  
end