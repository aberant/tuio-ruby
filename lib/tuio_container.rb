class TuioContainer < TuioPoint
  attr_accessor :session_id, :x_speed, :y_speed, :motion_accel
  
  def self.abstract?
    true
  end
  
  def initialize( session_id, x_pos, y_pos )
    raise "Abstract Classes can't be initialized!" if self.class.abstract?

    super( x_pos, y_pos )
    
    @session_id = session_id
    
    add_point_to_path( x_pos, y_pos )
  end
  
  def update( x_pos, y_pos, x_speed, y_speed, motion_accel )
    super( x_pos, y_pos)
    
    @x_speed = x_speed
    @y_speed = y_speed
    @motion_accel = motion_accel
    
    add_point_to_path( x_pos, y_pos )
  end
  
  def path
    @path 
  end
  
private

  def add_point_to_path( x_pos, y_pos )
    @path ||= []
    @path << TuioPoint.new( x_pos, y_pos )
  end
end

