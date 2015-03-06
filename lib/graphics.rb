module Graphics

  def self.included(base)
    java_import "java.awt.DisplayMode"
    java_import "java.awt.GraphicsDevice"
    java_import "java.awt.GraphicsEnvironment"
  end

  def graphics_device
    @device ||= GraphicsEnvironment.local_graphics_environment.default_screen_device
  end

  ##
  #  display_modes.each do |mode|
  #    puts "#{mode.width}x#{mode.height} #{mode.bit_depth}bit"
  #  end
  def display_modes
    graphics_device.display_modes
  end

end
