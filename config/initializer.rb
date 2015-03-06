Game.configure do |config|
  config.jme_version = "2012-10-19"
  config.logger = true
  config.settings.settings_dialog_image = "assets/images/maze_craze_logo.png"
  config.settings.set_resolution(1024, 768)
  config.settings.fullscreen = false
  config.settings.title = "Maze Craze"
end
