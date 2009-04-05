require File.join( File.dirname( __FILE__ ), '..', 'lib', 'tuio_client' )


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

@tc.start
sleep