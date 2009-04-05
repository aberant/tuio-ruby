require '../lib/tuio_client'


@tc = TuioClient.new

@tc.on_object_creation do | to |
  puts "New TUIO Object at x: #{to.x_pos}, y: #{to.y_pos}"
end

@tc.on_object_update do | to |
  puts "TUIO Object #{to.fiducial_id} path is:"
  to.path[0..9].each{|p| puts "x: #{p.x_pos}, y: #{p.y_pos}"}
end

tc.start
sleep