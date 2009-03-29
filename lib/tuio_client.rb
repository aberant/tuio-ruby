require 'rubygems'
require 'osc'


class TuioClient
  include OSC
  
  def initialize( args = {} )
    @port = args[:port] || 3333

    @tuio_objects = { }
    @tuio_cursors = { }
    
    @osc = OSC::SimpleServer.new(@port)
    
    @osc.add_method '/tuio/2Dobj' do |msg|
      args = msg.to_a
      
      case args.shift
      when "set"
        update_tuio_objects( args ) 
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
        update_tuio_cursors args
      when "alive"
        keep_alive( :tuio_cursors, args )
      when "fseq"
        #
      end
    end
  end
  
  def start
    Thread.new do
      @osc.run
    end
  end
  
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
  
  def on_object_update( &obj_update_blk )
    @obj_update_blk = obj_update_blk
  end
  
  def on_cursor_update( &cur_update_blk )
    @cur_update_blk = cur_update_blk
  end
  
private
  def cur_args_to_hash( args )
    { :session_id  => args[0],
      :x_pos       => args[1],
      :y_pos       => args[2],
      :x_move      => args[3],
      :y_move      => args[4],
      :motion_acc  => args[5],
    }
  end

  def obj_args_to_hash( args )
    { :session_id    =>  args[0],
      :class_id      =>  args[1],
      :x_pos         =>  args[2],
      :y_pos         =>  args[3],
      :angle         =>  args[4],
      :x_move        =>  args[5],
      :y_move        =>  args[6],
      :angle_move    =>  args[7],
      :motion_acc    =>  args[8],
      :rotation_acc  =>  args[9],
    }
  end
  
  def session_id_from( args )
    args[0]
  end
  
  def new_object_params_from( args )
    args[0..4]
  end
  
  def tuio_object_previously_tracked?( session_id )
    @tuio_objects.has_key?( session_id )
  end
  
  def grab_tuio_object_by( session_id )
    @tuio_objects[session_id]
  end
  
  def track_new_tuio_object_with( session_id, args )
    @tuio_objects[session_id] = TuioObject.new( *new_object_params_from( args ) )
  end
  
  def trigger_callbacks
    @obj_update_blk.call( @tuio_objects ) if @obj_update_blk
  end
  
  def update_tuio_objects( args )
    session_id = session_id_from( args )
    
    if tuio_object_previously_tracked?( session_id )
      grab_tuio_object_by( session_id ).update( *args )
    else
      track_new_tuio_object_with( session_id, args )
    end
    
    trigger_callbacks
  end
  
  def update_tuio_cursors( args )
    tuio_cursor = cur_args_to_hash( args )
    
    @tuio_cursors[tuio_cursor[:session_id]] = tuio_cursor
    @cur_update_blk.call( @tuio_cursors ) if @cur_update_blk
  end
  
  def keep_alive( type, session_ids )
    all_keys = send( type ).keys
    
    dead = all_keys.reject { |key|  session_ids.include? key }
        
    dead.each do |d|
      send( type ).delete( d )
    end
  end
end

if $0 == __FILE__
  TuioClient.new.start
end