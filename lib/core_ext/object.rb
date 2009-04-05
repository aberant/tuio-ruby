class Object
  def client_block_setter( *args )
    args.each do | blk_setter_name |      
     self.class_eval <<-EOF
        def on_#{blk_setter_name}( &#{blk_setter_name}_blk )
         @#{blk_setter_name}_callback_blk = #{blk_setter_name}_blk
        end
      EOF
    end
  end
end