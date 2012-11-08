class Player
  
  def initialize(app_state)
    capsule_shape = CapsuleCollisionShape.new(1.5, 15.0, 1)
    @player = CharacterControl.new(capsule_shape, 0.05)
    @player.jump_speed = 20
    @player.fall_speed = 30
    @player.gravity = 30
    @player.physics_location = Vector3f.new(-185, 15, -95)
    # This isn't being used yet.
    # player_model = $asset_manager.load_model(File.join("Models", "Oto", "Oto.mesh.xml"))
    # player_model.local_scale = 0.5
    # player_model.local_translation = Vector3f.new(-185, 15, -95)
    # player_model.add_control(player)
    # app_state.physics_space.add(player_model)
  end
  
  def walk_direction=(direction)
    @player.walk_direction = direction
  end
  
  def physics_location
    @player.physics_location
  end
  
end