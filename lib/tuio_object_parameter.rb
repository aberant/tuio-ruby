require 'tuio_parameter'
# /tuio/2Dobj set s i x y a X Y A m r


class TuioObjectParameter < TuioParameter
  attr_reader :angle, :fiducial_id, :rotation_vector, :rotation_accel
  
  def self.from_creation_args( *client_args )
    new client_args[0],
        client_args[1],
        client_args[2],
        client_args[3],
        client_args[4],
        0.0,
        0.0,
        0.0,
        0.0,
        0.0
  end
  
  def initialize( session_id, fiducial_id, x_pos, y_pos, angle, x_speed, y_speed, rotation_vector, motion_accel, rotation_accel )
    super( session_id, x_pos, y_pos, x_speed, y_speed, motion_accel )
    
    @fiducial_id = fiducial_id
    @angle = angle
    @rotation_vector = rotation_vector
    @rotation_accel = rotation_accel
  end
end