module Game
  class Window < SimpleApplication
    include ActionListener
    field_accessor :flyCam, :paused
    field_reader :cam, :settings

    def initialize
      super
      # Is there a better way to do this?
      self.settings = Game.settings
      self.show_settings = true
    end

    def simpleInitApp
      self.timer = NanoTimer.new
      $root_node = root_node
      $state_manager = state_manager
      $asset_manager = asset_manager
      $input_manager = input_manager
      $audio_renderer = audio_renderer
      $gui_view_port = gui_view_port
      # wish these could go in the initializer somehow
      self.display_fps = false
      self.display_stat_view = false
    end

  end
end
