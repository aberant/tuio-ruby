require File.join( File.dirname( __FILE__ ), 'tuio_container' )

class TuioCursor < TuioContainer
  
  attr_accessor :finger_id
  attr_reader  :x_speed, :y_speed, :motion_accel
  
  def self.from_params( params )
    new(  params.session_id,
          params.x_pos,
          params.y_pos 
    )
  end
  
  def initialize( session_id, x_pos, y_pos )
    super( session_id, x_pos, y_pos )
    
    @x_speed = 0.0
    @y_speed = 0.0
    @motion_accel = 0.0
  end

    
  def equal_to_local_params?( params )
    true
  end

end