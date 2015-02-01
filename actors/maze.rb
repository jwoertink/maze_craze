class Maze < Game::Window

  attr_accessor :playtime, :playing, :bullet_app_state, :player, :mark, :shootables, :gun_sound, :ambient_noise

  def initialize
    super
    @floor = {:width => 200, :height => 100}
    @wall = {:width => 10, :height => 20}
    self.playing = false
    @time_text = nil
    @counter = 0
    @targets = []
    @targets_generated = 0
    @game_state = 1
  end

  def simpleInitApp
    super
    #display_start_screen
    setupgame
  end

  def display_start_screen
    nifty_display = NiftyJmeDisplay.new($asset_manager, $input_manager, $audio_renderer, $gui_view_port)
    nifty = nifty_display.nifty
    controller = StartScreenController.new(self)
    nifty.from_xml(Game.scene_path('screen.xml'), 'start', controller)
    gui_view_port.add_processor(nifty_display)
    flyCam.enabled = false
    flyCam.drag_to_rotate = true
    input_manager.cursor_visible = true
  end

  def setupgame
    self.bullet_app_state = BulletAppState.new
    state_manager.attach(bullet_app_state)

    self.player = Player.new(bullet_app_state)

    sphere = Sphere.new(30, 30, 0.2)
    self.mark = Geometry.new("BOOM!", sphere)
    mark_mat = Material.new(asset_manager, "Common/MatDefs/Misc/Unshaded.j3md")
    mark_mat.set_color("Color", ColorRGBA::Red)
    mark.material = mark_mat

    setup_text!
    setup_camera!
    setup_floor!
    setup_sky!
    setup_keys!
    setup_light!
    setup_audio!

    generate_maze #(maze: static_maze)

    self.playing = true
    self.playtime = Time.now
    #flyCam.enabled = true
  end

  def static_maze
    maze =
<<-MAZE
_____________________
  |  _____   _____  |
| |_  |_  | |   | | |
|  _| |   |___| |___|
|   |___| |   |___  |
|_|   |  _|_|     | |
|  _|_|___  | | |_|_|
| |   |  ___|_|_    |
| | |___|  ___  |_| |
| | |  ___|  _| |   |
|_____|___________|__
MAZE
  end

  def generate_maze(opts = {})
    maze_width = opts[:width] || 10
    maze = opts[:maze] || Theseus::OrthogonalMaze.generate(:width => maze_width)
    rows = maze.to_s.split("\n")
    starting_left = -(@floor[:width] - @wall[:width])
    us_start = -@floor[:height]
    pipe_start = us_start - @wall[:width]
    start_wall = Wall.new(starting_left, 10, pipe_start + 20, 0, 10, 10, {:image => "start.jpg", :bullet_app_state => bullet_app_state})
    end_wall = Wall.new(@floor[:width] + 10, 0, @floor[:height] - 10, 10, 0, 10, {:image => "stop.jpg", :bullet_app_state => bullet_app_state})
    root_node.attach_child(start_wall.object)
    root_node.attach_child(end_wall.object)
    rows.each_with_index do |step, row|
      step.split(//).each_with_index do |type, col|
        move_right = starting_left + (col * 20) # May need that 20 to be dynamic....
        pipe_move_down = pipe_start + (row * 20)
        us_move_down = us_start + (row * 20)
        case type
        when "_"
          wall = Wall.new(move_right, @wall[:height], us_move_down, @wall[:width], @wall[:height], 0, {:bullet_app_state => bullet_app_state})
        when "|"
          wall = Wall.new(move_right, @wall[:height], pipe_move_down, @wall[:width], @wall[:height], 10, {:bullet_app_state => bullet_app_state})
        when " "
          # This is a space
          # Randomly generate a target
          if rand(100) > 90
            wall = Wall.new(move_right, @wall[:height], us_move_down, @wall[:width], @wall[:height], 0, {:image => "target.png", :name => "Target", :bullet_app_state => bullet_app_state})
            @targets_generated += 1
          end
        end

        root_node.attach_child(wall.object) unless wall.nil?
      end
    end

    #puts "\n\n#{maze}\n\n"
  end


  def setup_camera!
    flyCam.enabled = true
    flyCam.move_speed = 100
    flyCam.zoom_speed = 0
    cam.look_at_direction(Vector3f.new(10, 0, 0).normalize_local, Vector3f::UNIT_Y)
  end

  def setup_floor!
    floor = Box.new(Vector3f::ZERO, @floor[:width], 0.2, @floor[:height])
    floor.scale_texture_coordinates(Vector2f.new(3, 6))
    floor_mat = Material.new($asset_manager, "Common/MatDefs/Misc/Unshaded.j3md")
    key = TextureKey.new('assets/images/rock.jpg')
    key.generate_mips = true
    texture = $asset_manager.load_texture(key)
    texture.wrap = Texture::WrapMode::Repeat
    floor_mat.set_texture("ColorMap", texture)
    floor_geo = Geometry.new("Floor", floor)
    floor_geo.material = floor_mat
    floor_geo.set_local_translation(0, -0.1, 0)
    root_node.attach_child(floor_geo)
    floor_phy = RigidBodyControl.new(0.0)
    floor_geo.add_control(floor_phy)
    bullet_app_state.physics_space.add(floor_phy)
  end

  def setup_sky!
    root_node.attach_child(SkyFactory.create_sky($asset_manager, "Textures/Sky/Bright/BrightSky.dds", false))
    # view_port.background_color = ColorRGBA.new(ColorRGBA.random_color)
  end

  def setup_light!
    al = AmbientLight.new
    al.color = ColorRGBA::White.mult(1.3)
    root_node.add_light(al)
    dl = DirectionalLight.new
    dl.color = ColorRGBA::White
    dl.direction = Vector3f.new(2.8, -2.8, -2.8).normalize_local
    root_node.add_light(dl)
  end

  def setup_keys!
    input_manager.add_mapping("Left",  KeyTrigger.new(KeyInput::KEY_A))
    input_manager.add_mapping("Right", KeyTrigger.new(KeyInput::KEY_D))
    input_manager.add_mapping("Forward",    KeyTrigger.new(KeyInput::KEY_W))
    input_manager.add_mapping("Backward",  KeyTrigger.new(KeyInput::KEY_S))
    input_manager.add_mapping("Shoot", KeyTrigger.new(KeyInput::KEY_SPACE))
    input_manager.add_listener(ControllerAction.new(self), ["Left", "Right", "Forward", "Backward", "Shoot"].to_java(:string))
  end

  def setup_text!
    gui_node.detach_all_children
    gui_font = asset_manager.load_font("Interface/Fonts/Default.fnt")
    ch = BitmapText.new(gui_font, false)
    ch.size = gui_font.char_set.rendered_size * 2
    ch.text = "+"
    ch.set_local_translation(settings.width / 2 - gui_font.char_set.rendered_size / 3 * 2, settings.height / 2 + ch.line_height / 2, 0)
    gui_node.attach_child(ch)

    @target_text = BitmapText.new(gui_font, false)
    @target_text.size = 20
    @target_text.color = ColorRGBA::Red
    @target_text.text = "TARGETS: #{@targets.count} / #{@targets_generated.count}"
    @target_text.set_local_translation(50, 700, 10)
    gui_node.attach_child(@target_text)
  end

  # only mono audio is supported for positional audio nodes
  def setup_audio!
    self.gun_sound = AudioNode.new($asset_manager, "Sound/Effects/Gun.wav", false)
    gun_sound.positional = false
    gun_sound.looping = false
    gun_sound.volume = 3
    root_node.attach_child(gun_sound)

    self.ambient_noise = AudioNode.new(asset_manager, "assets/sound/lost.ogg", false)
    ambient_noise.looping = true
    ambient_noise.positional = true
    ambient_noise.local_translation = Vector3f::ZERO.clone
    ambient_noise.volume = 2
    root_node.attach_child(ambient_noise)
    ambient_noise.play
  end

  def simpleUpdate(tpf)
    cam_dir = cam.direction.clone.mult_local(0.6)
    cam_left = cam.left.clone.mult_local(0.4)
    player.direction.set(0, 0, 0)
    player.direction.add_local(cam_left) if player.left?
    player.direction.add_local(cam_left.negate) if player.right?
    player.direction.add_local(cam_dir) if player.forward?
    player.direction.add_local(cam_dir.negate) if player.backward?
    player.move_direction = player.direction # this is weird... do not like
    cam.location = player.location
    if cam.location.x > (@floor[:width]) && cam.location.z > (@floor[:height] - 20) && playing?
      # Found the end
      if @targets.empty? && @targets_generated > 0
        @target_text.text = "YOU MUST SHOOT A TARGET FIRST!"
      else
        self.playing = false
        finish_time = Time.now - playtime
        # @target_text.text = "FINISH TIME: #{finish_time.ceil} seconds. You shot #{@targets.size}/#{@targets_generated} targets"
        self.paused = true
        input_manager.cursor_visible = true
        flyCam.enabled = false
        # use nifty
      end
    end
  end

  def playing?
    playing
  end

  def update_target(spacial)
    unless @targets.include? spacial
      @targets << spacial
      root_node.detach_child(mark)
      spacial.remove_from_parent
      @target_text.text = "TARGETS: #{@targets.count} / #{@targets_generated.count}"
      bullet_app_state.physics_space.remove(spacial.get_control(RigidBodyControl.java_class))
    end
  end

  class ControllerAction
    include ActionListener

    def initialize(obj)
      @parent = obj
    end

    def on_action(binding, value, tpf)
      @parent.player.send("#{binding.downcase}=", value) if @parent.player.respond_to?("#{binding.downcase}=")
      if binding.eql?("Shoot") && !value
        @parent.gun_sound.play_instance
        results = CollisionResults.new
        ray = Ray.new(@parent.cam.location, @parent.cam.direction)
        @parent.root_node.collide_with(ray, results)
        if results.size > 0
          closest = results.closest_collision
          @parent.mark.local_translation = closest.contact_point
          @parent.root_node.attach_child(@parent.mark)
        else
          @parent.root_node.detach_child(@parent.mark)
        end
        results.each_with_index do |result, index|
          collision = results.get_collision(index)
          dist = collision.distance
          pt = collision.contact_point
          spacial = collision.geometry
          hit = spacial.name
          if hit.eql?("Target")
            @parent.update_target(spacial)
          end
        end
      end
    end

  end
end
