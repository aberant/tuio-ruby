class Float 
  def approx_equal?(other,threshold=0.00001) 
    (self-other).abs < threshold  
  end 
end