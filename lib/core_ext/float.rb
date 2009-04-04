class Float 
  def approx_equal?(other,threshold=0.00001) 

    if (self-other).abs < threshold    # "<" not exact either ;-) 
      return true 
    else 
      return false 
    end 
  end 
end