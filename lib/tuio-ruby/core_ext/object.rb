# this is a little meta magic to clean up some of the repetition in the client
# i noticed that i kept making the same similiar methods for each event such as
#
# client_events :object_creation
#
# which causes these two methods to be created

# def on_object_creation( &object_creation_blk )
#  @object_creation_callback_blk = object_creation_blk
# end
# 
# def trigger_object_creation_callback( tuio )
#   @object_creation_callback_blk.call( tuio ) if @object_creation_callback_blk
# end

class Object
  def client_events( *args )
    args.each do | event | 
     self.class_eval <<-EOF
        def on_#{event}( &#{event}_blk )
         @#{event}_callback_blk = #{event}_blk
        end
        
        def trigger_#{event}_callback( tuio )
          @#{event}_callback_blk.call( tuio ) if @#{event}_callback_blk
        end
      EOF
    end
  end
end