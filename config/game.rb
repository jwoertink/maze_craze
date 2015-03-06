java_import "com.jme3.system.AppSettings"
java_import "java.util.logging.Level"
java_import "java.util.logging.Logger"

require 'lib/utilities'

module Game
  include Utilities
  VERSION = '1.0'

  class << self
    attr_accessor :jme_version, :logger, :settings

    def configure
      self.settings = AppSettings.new(true)
      yield self
      #should move this into the actual initializer
      Logger.get_logger("").level = Level::WARNING
    end

    def run
      Maze.new.start
    end
  end

end
