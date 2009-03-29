# require File.join( File.dirname( __FILE__ ), 'tuio_point' )
class TuioObject < TuioContainer
  attr_accessor :angle, :fiducial_id, :rotation_speed, :rotation_accel
  
  def self.abstract?
    false
  end
  
  def initialize( session_id, fiducial_id, x_pos,  y_pos, angle )
    super( session_id, x_pos, y_pos )
    
    @fiducial_id = fiducial_id
    @angle = angle
  end 
  
  def update( x_pos, y_pos, angle, x_speed, y_speed, rotation_speed, motion_accel, rotation_accel )
    super( x_pos, y_pos, x_speed, y_speed, motion_accel )
    
    @angle = angle
    @rotation_speed = rotation_speed
    @rotation_accel = rotation_accel
  end
end