require 'rubygems'
require 'osc'



class TUIOClient
  include OSC
  
  def initialize( args = {} )
    @port = args[:port] || 3333

    @tuio_objects = { }
    @tuio_cursors = { }
    
    @osc = OSC::SimpleServer.new(@port)
    
    @osc.add_method '/tuio/2Dobj', nil do |msg|
      args = msg.to_a
      
      case args.shift
      when "set"
        update_tuio_objects( args ) 
      when "alive"
        keep_alive( :tuio_objects, args )
      when "fseq"
        puts args
      end
    end

    @osc.add_method '/tuio/2Dcur', nil do |msg|
      args = msg.to_a

      case args.shift
      when "set"
        update_tuio_cursors args
      when "alive"
        keep_alive( :tuio_cursors, args )
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
  
  def update_tuio_objects( args )
    tuio_object = obj_args_to_hash( args )
    
    @tuio_objects[tuio_object[:session_id]] = tuio_object
  end
  
  def update_tuio_cursors( args )
    tuio_cursor = cur_args_to_hash( args )
    @tuio_cursors[tuio_cursor[:session_id]] = tuio_cursor
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
  TUIOClient.new.start
end