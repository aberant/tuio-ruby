class TuioPoint
  attr_accessor :x_pos, :y_pos, :updated_at
  
  def initialize( x_pos, y_pos )
    @x_pos, @y_pos = x_pos, y_pos
  end
  
  def update( x_pos, y_pos )
    @x_pos, @y_pos = x_pos, y_pos
  
    clear_update_time
  end
  
  def distance_to( another_point )
    dx = @x_pos - another_point.x_pos
    dy = @y_pos - another_point.y_pos
    
    Math.sqrt( dx*dx + dy*dy )
  end
  
  def radians_to( another_point )
    side =   another_point.x_pos - @x_pos
    height = another_point.y_pos - @y_pos
    distance = distance_to( another_point )
    
    angle = Math.asin( side / distance ) + Math::PI / 2 
    angle = 2.0 * Math.PI - angle if height < 0 
    angle
  end
  
  def degrees_to( another_point )
    ( radians_to( another_point ) / Math::PI ) * 180.0
  end
  
  def eql?( another_point )
    @x_pos == another_point.x_pos &&
    @y_pos == another_point.y_pos
  end
  
private

  def clear_update_time
    @updated_at = nil
  end
end