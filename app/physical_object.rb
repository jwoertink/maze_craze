class PhysicalObject
  attr_accessor :object, :model
  
  def initialize(app_state)
    capsule_shape = CapsuleCollisionShape.new(1.5, 15.0, 1)
    @object = CharacterControl.new(capsule_shape, 0.05)
    @object.jump_speed = 20
    @object.fall_speed = 30
    @object.gravity = 30
    @object.physics_location = Vector3f.new(-185, 15, -95)
  end
  
  def move_direction=(direction)
    @object.walk_direction = direction
  end
  
  def move_direction
    @object.walk_direction
  end
  
  def location
    @object.physics_location
  end
  
  def jump_speed
    @object.jump_speed
  end
  
  def fall_speed
    @object.fall_speed
  end
  
  def gravity
    @object.gravity
  end
  
end