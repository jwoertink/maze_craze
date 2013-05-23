require 'app/movable'

class Player < PhysicalObject
  include Movable
  
  def initialize(app_state)
    super
    @model = $asset_manager.load_model(File.join("Models", "Oto", "Oto.mesh.xml"))
    @model.local_scale = 0.5
    @model.local_translation = Vector3f.new(-185, 15, -95)
    @model.add_control(object)
    app_state.physics_space.add(@model)
  end
  
  
  
end