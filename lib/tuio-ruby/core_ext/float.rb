class Float 
  def approx_equal?(other,threshold=0.00000000001) 
    (self-other).abs < threshold  
  end 
end