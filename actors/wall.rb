class Wall
  attr_accessor :object

  #  vx = x position
  #   '_' => -(floor_width - wall_width)
  #   '|' => -floor_height
  #  vy = elevation
  #   vy == by
  #  vz = y position
  #   '_' = -floor_height
  #   '|' = -(floor_height - wall_width)
  #  bx = x width
  #  by = height
  #  bz = y width
  def initialize(x_pos, elevation, y_pos, x_width, height, y_width, opts = {})
    image = opts[:image] || 'brickwall.jpg'
    name = opts[:name] || "a Wall"
    box = Box.new(Vector3f.new(x_pos, elevation, y_pos), x_width, height, y_width)
    self.object = Geometry.new(name, box)
    matl = Material.new($asset_manager, "Common/MatDefs/Misc/Unshaded.j3md")
    matl.set_texture("ColorMap", $asset_manager.load_texture(File.join('assets', 'images', image)))
    matl.additional_render_state.blend_mode = RenderState::BlendMode::Alpha if image.include?(".png")
    object.material = matl
    scene_shape = CollisionShapeFactory.create_mesh_shape(object)
    landscape = RigidBodyControl.new(scene_shape, 0)
    object.add_control(landscape)
    opts[:bullet_app_state].physics_space.add(landscape)
    object
  end

end
