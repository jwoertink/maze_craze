java_import "com.jme3.system.AppSettings"
java_import "java.util.logging.Level"
java_import "java.util.logging.Logger"
# java_import "java.awt.DisplayMode"
# java_import "java.awt.GraphicsDevice"
# java_import "java.awt.GraphicsEnvironment"

module Game
  VERSION = '1.0'
  
  class << self
    attr_accessor :jme_version, :logger, :settings
    
    def configure
      self.settings = AppSettings.new(true)
      yield self
      #should move this into the actual initializer
      Logger.get_logger("").level = Level::WARNING
      # device = GraphicsEnvironment.local_graphics_environment.default_screen_device
      # modes = device.display_modes
      # modes.each do |mode|
      #   puts "#{mode.width}x#{mode.height} #{mode.bit_depth}bit"
      # end
      # self.stop
    end
    
    def asset_path(filename)
      ext = File.extname(filename)[1..-1].downcase
      type = case ext
      when 'jpg', 'png', 'gif', 'tiff', 'bmp'
        'images'
      when 'ogg', 'mp3'
        'sound'
      end
      File.join(GAME_ROOT_PATH, "assets", type, filename)
    end
  
    def run
      require 'config/imports'
      Maze.new.start
    end
  end
  
end