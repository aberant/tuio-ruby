require 'tuio_parameter'

# /tuio/2Dcur set s x y X Y m

class TuioCursorParameter < TuioParameter

  def self.from_update_args( session_id, x_pos, y_pos, x_speed, y_speed, motion_accel )
    new( session_id, x_pos, y_pos, x_speed, y_speed, motion_accel)
  end
end