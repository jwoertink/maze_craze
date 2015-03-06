# task :dist do
#   Puck::Jar.new.create!
# end

desc "Enter the console with the game pre-loaded"
task :console do
  require 'irb'
  require 'irb/completion'
  require_relative 'config/load'
  ARGV.clear
  IRB.start
end

desc "Build and play the game"
task :build do
  require_relative 'config/load'
  # Compile needed jar files here
  Game.run
end
