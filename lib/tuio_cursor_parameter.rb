require 'tuio_parameter'

# /tuio/2Dcur set s x y X Y m

class TuioCursorParameter < TuioParameter
  def self.from_creation_args( *client_args )
    new client_args[0],
        client_args[1],
        client_args[2],
        0,
        0,
        0  
  end

  def self.from_update_args( session_id, x_pos, y_pos, x_speed, y_speed, motion_accel )
    new( session_id, x_pos, y_pos, x_speed, y_speed, motion_accel)
  end
end