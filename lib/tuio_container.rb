require 'tuio_point'

class TuioContainer < TuioPoint
  attr_accessor :session_id, :x_pos, :y_pos, :x_speed, :y_speed, :motion_accel

  
  def initialize( session_id, x_pos, y_pos )
    super( x_pos, y_pos )

    @session_id = session_id
    @x_speed = 0.0
    @y_speed = 0.0
    @motion_accel = 0.0
    
    add_point_to_path( TuioPoint.new( x_pos, y_pos ) )
  end
  
  def update( x_pos, y_pos, x_speed, y_speed, motion_accel )  
    super( x_pos, y_pos )
    
    @x_speed = x_speed
    @y_speed = y_speed
    @motion_accel = motion_accel
    
    new_point = TuioPoint.new( x_pos, y_pos )
    add_point_to_path( new_point ) unless new_point == @path.last
  end
  
  def update_from_params( params )
    @x_pos = params.x_pos
    @y_pos = params.y_pos
    @x_speed = params.x_speed
    @y_speed = params.y_speed
    @motion_accel = params.motion_accel
  end
  
  def path
    @path 
  end
  
  
  def params_equal?( params )
    @session_id == params.session_id &&
    @x_pos.approx_equal?( params.x_pos ) &&
    @y_pos.approx_equal?( params.y_pos ) &&
    @x_speed.approx_equal?( params.x_speed ) &&
    @y_speed.approx_equal?( params.y_speed ) &&
    @motion_accel.approx_equal?( params.motion_accel ) && 
    equal_to_local_params?( params )
  end
  
  def equal_to_local_args?(args)
    true
  end
  
private

  def add_point_to_path( tuio_point )
    @path ||= []
    @path << tuio_point
  end
end

