module Game
  class Base < SimpleApplication
    include ActionListener
    field_accessor :flyCam, :paused
    field_reader :cam, :settings
    
    def initialize
      super
      # Is there a better way to do this?
      self.settings = Game.settings
      self.show_settings = false
    end
    
    def simpleInitApp
      super
      self.timer = NanoTimer.new
      $root_node = root_node
      $state_manager = state_manager
      $asset_manager = asset_manager
      $input_manager = input_manager
      $audio_renderer = audio_renderer
      $gui_view_port = gui_view_port
    end
    
  end
end