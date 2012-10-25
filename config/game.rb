require File.join(__FILE__, 'imports')

Bundler.require if defined?(Bundler)

module MazeCraze
  
  Game.configure do |config|
    config.jme_version = "2012-10-19"
  end
  
  class Game
    attr_accessor :jme_version
    
    def self.configure
      yield self
    end
  
    def self.run
      Maze.new.start
    end
  end
  
end