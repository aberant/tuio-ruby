require File.join( File.dirname( __FILE__ ), 'tuio_container' )

class TuioObject < TuioContainer
  attr_reader :angle, :fiducial_id, :rotation_vector, :rotation_accel

  def self.from_params( params )
    new(
      params.session_id,
      params.fiducial_id,
      params.x_pos,
      params.y_pos,
      params.angle
    )
  end

  def initialize( session_id, fiducial_id, x_pos,  y_pos, angle )
    super( session_id, x_pos, y_pos )

    @fiducial_id = fiducial_id
    @angle = angle

    @rotation_vector = 0.0
    @rotation_accel = 0.0
  end

  def update_from_params( tuio_params )
    update(
      tuio_params.x_pos,
      tuio_params.y_pos,
      tuio_params.angle,
      tuio_params.x_speed,
      tuio_params.y_speed,
      tuio_params.rotation_vector,
      tuio_params.motion_accel,
      tuio_params.rotation_accel
    )
  end

  def update( x_pos, y_pos, angle, x_speed, y_speed, rotation_vector, motion_accel, rotation_accel )
    super( x_pos, y_pos, x_speed, y_speed, motion_accel )

    @angle = angle
    @rotation_vector = rotation_vector
    @rotation_accel = rotation_accel
  end

  def equal_to_local_params?( params )
    fiducial_id == params.fiducial_id &&
    rotation_vector.approx_equal?( params.rotation_vector ) &&
    rotation_accel.approx_equal?( params.rotation_accel )
  end
end