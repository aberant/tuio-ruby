# require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )
# 
# class TuioContainer
#   # we want to be able to instantiate this class for testing
#   def self.abstract?
#     false
#   end
# end
# 
# describe TuioContainer do
#   before :each do
#     @session_id = 42
#     @x_pos = 0.8
#     @y_pos = 0.3
#     @tc = TuioContainer.new( @session_id, @x_pos, @y_pos )
#   end
#   
#   describe "in general" do
#     it "should know it's session id" do
#       @tc.session_id.should == @session_id
#     end
#   
#     it "should know it's x position" do
#       @tc.x_pos.should == @x_pos
#     end
#   
#     it "should know its y position" do
#       @tc.y_pos.should == @y_pos
#     end
#   end
#   
#   describe "updates" do
#     before :each do
#       @x_pos2 = 0.7
#       @y_pos2 = 0.4
#       @x_speed = 0.1
#       @y_speed = 0.1
#       @motion_accel = 0.1
#       
#       @tc.update( @x_pos2, @y_pos2, @x_speed, @y_speed, @motion_accel )
#     end
# 
#     it "should know it's new x position" do
#       @tc.x_pos.should == @x_pos2
#     end
#     
#     it "should know it's new y position" do
#       @tc.y_pos.should == @y_pos2
#     end
#     
#     it "should know it's x speed" do
#       @tc.x_speed.should == @x_speed
#     end
#     
#     it "should know it's y speed" do
#       @tc.y_speed.should == @y_speed
#     end
#     
#     it "should know it's motion acceleration" do
#       @tc.motion_accel.should == @motion_accel
#     end
#     
#     it "should know the path it's traveled" do
#       first = @tc.path.first
#       second = @tc.path.last
#       
#       first.x_pos.should == 0.8
#       first.y_pos.should == 0.3
#       
#       second.x_pos.should == 0.7
#       second.y_pos.should == 0.4
#     end
#   end
# end
