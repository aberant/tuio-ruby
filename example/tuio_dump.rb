require '../lib/tuio_client'


tc = TuioClient.new

tc.on_object_creation do | to |
  puts to.inspect
end

tc.start
sleep