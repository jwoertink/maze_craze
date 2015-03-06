require 'rubygems'
require 'java'
require 'jruby/core_ext'
require 'bundler'

GAME_ROOT_PATH = File.join(File.dirname(__FILE__), '..')

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] = File.join(GAME_ROOT_PATH, 'Gemfile')
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require(:default, :development) if defined?(Bundler)

$:.unshift(GAME_ROOT_PATH)
$CLASSPATH << File.join(GAME_ROOT_PATH, "java", "classes")

require 'config/game'
require 'config/initializer'
require 'config/extensions'
require 'config/imports'

require 'jmonkeyengine'
