module TuioContainer 
  attr_accessor :session_id, :x_pos, :y_pos, :x_speed, :y_speed, :motion_accel

  
  def initialize( session_id, x_pos, y_pos )
    @session_id = session_id
    @x_pos = x_pos
    @y_pos = y_pos
    
    add_point_to_path( TuioPoint.new( x_pos, y_pos ) )
  end
  
  def update( x_pos, y_pos, x_speed, y_speed, motion_accel )  
    @x_pos = x_pos
    @y_pos = y_pos  
    @x_speed = x_speed
    @y_speed = y_speed
    @motion_accel = motion_accel
    
    new_point = TuioPoint.new( x_pos, y_pos )
    add_point_to_path( new_point ) unless new_point == @path.last
  end
  
  def path
    @path 
  end
  
  def args_equal?( args )
    @session_id == args[0] 
  end
  
private

  def add_point_to_path( tuio_point )
    @path ||= []
    @path << tuio_point
  end
end

