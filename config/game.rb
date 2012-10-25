Bundler.require if defined?(Bundler)

module MazeCraze
  VERSION = '1.0'
  
  class << self
    attr_accessor :jme_version, :logger
    
    def configure
      yield self
    end
  
    def run
      require 'config/imports'
      Maze.new.start
    end
  end
  
end