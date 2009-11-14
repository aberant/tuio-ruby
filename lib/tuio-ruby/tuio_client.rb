require 'rubygems'
require 'osc-ruby'

# core exts
require 'tuio-ruby/core_ext/object'
require 'tuio-ruby/core_ext/float'

class TuioClient
  include OSC
  
  attr_reader :tuio_objects, :tuio_cursors
  
  
  client_events :object_creation, :object_update, :object_removal
  client_events :cursor_creation, :cursor_update, :cursor_removal
  
  def initialize( args = {} )
    @port = args[:port] || 3333

    @tuio_objects = { }
    @tuio_cursors = { }
    
    @osc = OSC::Server.new(@port)
    
    @osc.add_method '/tuio/2Dobj' do |msg|
      args = msg.to_a
      
      case args.shift
      when "set"
        track_tuio_object( args ) 
      when "alive"
        keep_alive( :tuio_objects, args )
      when "fseq"
        # puts args
      end
    end

    @osc.add_method '/tuio/2Dcur' do |msg|
      args = msg.to_a

      case args.shift
      when "set"
        track_tuio_cursor args
      when "alive"
        keep_alive( :tuio_cursors, args )
      when "fseq"
        # puts args
      end
    end
  end
  
  def start
    Thread.new do
      @osc.run
    end
  end
  
  ####################################
  #           getters                #
  ####################################
  
  def tuio_object( id )
    @tuio_objects[id]
  end
  
  def tuio_cursor( id )
    @tuio_cursors[id]
  end
  
private

  def track_tuio_object( args )
    params = TuioObjectParameter.new( *args )
    
    if tuio_object_previously_tracked?( params )
      
      tuio_object = grab_tuio_object_by( params.session_id )
      
      return if tuio_object.params_equal?( params )

      tuio_object.update_from_params( params )  

      trigger_object_update_callback( tuio_object )
    else # this is a new object
      tuio_object = track_new_tuio_object_with( params )
      
      trigger_object_creation_callback( tuio_object  )
    end
  end
  
  def track_tuio_cursor( args )
    params = TuioCursorParameter.new( *args )
    
    if tuio_cursor_previously_tracked?( params )
      
      tuio_cursor = grab_tuio_cursor_by( params.session_id )
      
      return if tuio_cursor.params_equal?( params )
      tuio_cursor.update_from_params( params )
      
      trigger_cursor_update_callback( tuio_cursor )
      
    else # this is a new cursor      
      finger_id = @tuio_cursors.size
      tuio_cursor = track_new_tuio_cursor_with( params )

      trigger_cursor_creation_callback( tuio_cursor  )
    end
  end
  
  def tuio_object_previously_tracked?( params )
    @tuio_objects.has_key?( params.session_id )
  end
  
  def tuio_cursor_previously_tracked?( params )
    @tuio_cursors.has_key?( params.session_id )
  end
  
  def grab_tuio_object_by( session_id )
    @tuio_objects[session_id]
  end
  
  def grab_tuio_cursor_by( session_id )
    @tuio_cursors[session_id]
  end
  
  def track_new_tuio_object_with( tuio_params )
    @tuio_objects[tuio_params.session_id] = TuioObject.from_params( tuio_params )    
  end

  def track_new_tuio_cursor_with( params )  
    new_cursor = TuioCursor.from_params( params )
    @tuio_cursors[params.session_id] =  new_cursor
    
    new_cursor.finger_id = @tuio_cursors.size
    new_cursor
  end
  
  ####################################
  #           "alive" msgs           #
  ####################################
  
  def delete_tuio_objects( session_id )
    tuio_object = grab_tuio_object_by( session_id )
    
    trigger_object_removal_callback( tuio_object )
  end
  
  def delete_tuio_cursors( session_id )
    tuio_cursor = grab_tuio_cursor_by( session_id )
    
    trigger_cursor_removal_callback( tuio_cursor )
  end
  
  
  def keep_alive( type, session_ids )
    return if session_ids.nil?
    all_keys = send( type ).keys
    
    dead = all_keys.reject { |key|  session_ids.include? key }
        
    dead.each do | session_id |
      send( "delete_#{type}", session_id )
      
      send( type ).delete( session_id )
    end
  end
end