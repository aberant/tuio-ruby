require 'tuio_container'

class TuioObject < TuioContainer
  attr_reader :angle, :fiducial_id, :rotation_speed, :rotation_accel
  
  
  def initialize( session_id, fiducial_id, x_pos,  y_pos, angle )
    super( session_id, x_pos, y_pos )

    @fiducial_id = fiducial_id
    @angle = angle
    
    @rotation_speed = 0.0
    @rotation_accel = 0.0
  end 
  
  def update( x_pos, y_pos, angle, x_speed, y_speed, rotation_speed, motion_accel, rotation_accel )
    super( x_pos, y_pos, x_speed, y_speed, motion_accel )
    
    @angle = angle
    @rotation_speed = rotation_speed
    @rotation_accel = rotation_accel
  end
  
  def args_equal?( args )
    fiducial_id == args[1] &&
    rotation_speed.approx_equal?( args[7] ) && 
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
  
  def inspect
    puts "TuioObject:"
    puts "session_id >> #{session_id}"
    puts "fiducial_id >> #{fiducial_id}"
    puts "x_pos >> #{x_pos}"
    puts "y_pos >> #{y_pos}"
    puts "angle >> #{angle}"
    puts "x_speed >> #{x_speed}"
    puts "y_speed >> #{y_speed}"
    puts "rotation_speed >> #{rotation_speed}"
    puts "motion_accel >> #{motion_accel}"
    puts "rotation_accel >> #{rotation_accel}"
  end

private
  def args_to_container_from_object( args )
      #session_id, 
    [ args[0],

      # x_pos
      args[2], 

      # y_pos
      args[3], 

      # x_speed
      args[5], 

      # y_speed
      args[6], 

      # motion_accel
      args[8] ]
  end
end