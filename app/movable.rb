module Movable
  
  def direction
    @direction ||= Vector3f.new
  end
  
  def left?
    @left
  end
  
  def left=(moving_left = false)
    @left = moving_left
  end
  
  def right?
    @right
  end
  
  def right=(moving_right = false)
    @right = moving_right
  end
  
  def forward?
    @forward
  end
  
  def forward=(moving_forward = false)
    @forward = moving_forward
  end
  
  def backward?
    @backward
  end
  
  def backward=(moving_backward = false)
    @backward = moving_backward
  end
  
end