class TuioParameter
  attr_accessor :session_id, :x_pos, :y_pos, :x_speed, :y_speed, :motion_accel
  
  def self.new_from_initial_params( session_id, x_pos, y_pos )
    new session_id, x_pos, y_pos, 0.0, 0.0, 00
  end
  
  def initialize( session_id, x_pos, y_pos, x_speed, y_speed, motion_accel )
    @session_id = session_id
    @x_pos = x_pos
    @y_pos = y_pos
    @x_speed = x_speed
    @y_speed = y_speed
    @motion_accel = motion_accel
  end
end
