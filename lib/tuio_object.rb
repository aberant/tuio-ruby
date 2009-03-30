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
  
  def eql?( args )
    @session_id     == args[0]  &&
    @fiducial_id    == args[1]  &&
    @x_pos          == args[2]  &&
    @y_pos          == args[3]  &&
    @angle          == args[4]  &&
    @x_speed        == args[5]  &&
    @y_speed        == args[6]  &&
    @rotation_speed == args[7]  &&
    @motion_accel   == args[8]  &&
    @rotation_accel == args[9]
  end
end