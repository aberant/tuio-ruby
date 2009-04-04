class TuioObject 
  attr_accessor :angle, :fiducial_id, :rotation_speed, :rotation_accel
  
  include TuioContainer
  
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
  
  def args_equal?( args )
    fiducial_id == args[1] &&
    rotation_speed &&  rotation_speed.approx_equal?( args[7] ) && 
    rotation_accel.approx_equal?( args[9] ) &&
    super( args_to_container_from_object( args ) )
  end
  
  def to_args
    [ session_id,
      fiducial_id,
      x_pos,
      y_pos,
      angle,
      x_speed,
      y_speed,
      rotation_speed,
      motion_accel,
      rotation_accel]
  end

private 
  def args_to_container_from_object( args )
    [ args[0], args[2], args[3], args[4], args[5], args[6] ]
  end
end