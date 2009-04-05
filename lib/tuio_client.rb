require 'rubygems'
require 'osc'

require File.join( File.dirname( __FILE__ ), 'my_environment')

require "tuio_object"
require "tuio_cursor"

class TuioClient
  include OSC
  
  client_block_setter :object_creation, :object_update, :object_removal
  client_block_setter :cursor_creation, :cursor_update, :cursor_removal
  
  def initialize( args = {} )
    @port = args[:port] || 3333

    @tuio_objects = { }
    @tuio_cursors = { }
    
    @osc = OSC::SimpleServer.new(@port)
    
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
  
  def tuio_objects
    @tuio_objects
  end
  
  def tuio_object( id )
    @tuio_objects[id]
  end
  
  def tuio_cursors
    @tuio_cursors
  end  
    
  def tuio_cursor( id )
    @tuio_cursors[id]
  end
  
  ####################################
  #           call backs             #
  ####################################
  
  # def on_cursor_update( &cur_update_blk )
  #   @cur_update_blk = cur_update_blk
  # end
  
private

  def track_tuio_object( args )
    session_id = session_id_from( args )
  
    if tuio_object_previously_tracked?( session_id )
      
      tuio_object = grab_tuio_object_by( session_id )
      
      return if tuio_object.args_equal?( args )

      tuio_object.update( *update_object_params_from( args ) )  

      trigger_object_update_callback( tuio_object )
    else
      tuio_object = track_new_tuio_object_with( session_id, args )
      
      trigger_object_creation_callback( tuio_object  )
    end
  end
  
  def track_tuio_cursor( args )
    session_id = session_id_from( args )
    
    if tuio_cursor_previously_tracked?( session_id )
      tuio_cursor = grab_tuio_cursor_by( session_id )
      
      return if tuio_cursor.args_equal?( args )
      tuio_cursor.update( *update_cursor_params_from( args ))
      
      trigger_cursor_update_callback( tuio_cursor )
      
    else # this is a new cursor      
      finger_id = @tuio_cursors.size
      track_new_tuio_cursor_with( session_id, args )
      
      trigger_cursor_creation_callback( grab_tuio_cursor_by( session_id )  )
      
    end
  end
  
  def session_id_from( args )
    args[0]
  end
  
  def new_object_params_from( args )
    args[0..4]
  end
  
  def update_object_params_from( args )
    args[2..9]
  end
  
  def new_cursor_params_from( args )
    args[0..2]
  end

  def update_cursor_params_from( args )
    args[1..5]
  end

  
  def tuio_object_previously_tracked?( session_id )
    @tuio_objects.has_key?( session_id )
  end
  
  def tuio_cursor_previously_tracked?( session_id )
    @tuio_cursors.has_key?( session_id )
  end
  
  def grab_tuio_object_by( session_id )
    @tuio_objects[session_id]
  end
  
  def grab_tuio_cursor_by( session_id )
    @tuio_cursors[session_id]
  end
  
  def track_new_tuio_object_with( session_id, args )
    @tuio_objects[session_id] = TuioObject.new( *new_object_params_from( args ) )    
  end

  def track_new_tuio_cursor_with( session_id, args )    
    @tuio_cursors[session_id] = TuioCursor.new( *new_cursor_params_from( args ) ) 
  end

  ####################################
  #           call backs             #
  ####################################
  
  def trigger_object_update_callback( tuio_object )
    @object_update_callback_blk.call( tuio_object ) if @object_update_callback_blk
  end
  
  def trigger_object_creation_callback( tuio_object )
    @object_creation_callback_blk.call( tuio_object ) if @object_creation_callback_blk
  end
  
  def trigger_object_deletion_callback( tuio_object )
    @object_removal_callback_blk.call( tuio_object ) if @object_removal_callback_blk
  end
  
  def trigger_cursor_creation_callback( tuio_cursor )
    @cursor_creation_callback_blk.call( tuio_cursor ) if @cursor_creation_callback_blk
  end
  
  def trigger_cursor_update_callback( tuio_cursor )
    @cursor_update_callback_blk.call( tuio_cursor ) if @cursor_update_callback_blk
  end
  
  def trigger_cursor_update_callback( tuio_cursor )    
    @cursor_update_callback_blk.call( tuio_cursor ) if @cursor_update_callback_blk
  end
  
  def trigger_cursor_deletion_callback( tuio_object )
    @cursor_removal_callback_blk.call( tuio_object ) if @cursor_removal_callback_blk
  end
  
  def delete_tuio_objects( session_id )
    tuio_object = grab_tuio_object_by( session_id )
    
    trigger_object_deletion_callback( tuio_object )
  end
  
  def delete_tuio_cursors( session_id )
    tuio_cursor = grab_tuio_cursor_by( session_id )
    
    trigger_cursor_deletion_callback( tuio_cursor )
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

if $0 == __FILE__
  TuioClient.new.start
end