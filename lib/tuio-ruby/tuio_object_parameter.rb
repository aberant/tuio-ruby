require File.join( File.dirname( __FILE__ ), 'tuio_parameter' )

# /tuio/2Dobj set s i x y a X Y A m r


class TuioObjectParameter < TuioParameter
  attr_reader :angle, :fiducial_id, :rotation_vector, :rotation_accel
  
  def initialize( session_id, fiducial_id, x_pos, y_pos, angle, x_speed, y_speed, rotation_vector, motion_accel, rotation_accel )
    super( session_id, x_pos, y_pos, x_speed, y_speed, motion_accel )
    
    @fiducial_id = fiducial_id
    @angle = angle
    @rotation_vector = rotation_vector
    @rotation_accel = rotation_accel
  end
end