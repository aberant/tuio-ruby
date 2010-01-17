require 'rubygems'
require 'osc-ruby'

$:.unshift( File.join( File.dirname( __FILE__ ), '..', 'lib' ))
require 'tuio-ruby'

@tc = TuioClient.new

@tc.on_object_creation do | to |
  puts "New TUIO Object at x: #{to.x_pos}, y: #{to.y_pos}"
end

@tc.on_object_update do | to |
  puts "Updated TUIO Object #{to.fiducial_id} at x: #{to.x_pos}, y: #{to.y_pos}"
end

@tc.on_object_removal do | to |
  puts "Removed TUIO Object #{to.fiducial_id}"
end


@tc.on_cursor_creation do | to |
  puts "New TUIO Cursor at x: #{to.x_pos}, y: #{to.y_pos}"
end

@tc.on_cursor_update do | to |
  puts "Updated TUIO Cursor #{to.session_id} at x: #{to.x_pos}, y: #{to.y_pos}"
end

@tc.on_cursor_removal do | to |
  puts "Removed TUIO Cursor #{to.session_id}"
end

@tc.start
sleep