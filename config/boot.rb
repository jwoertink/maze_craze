require 'rubygems'
require 'java'
require 'jruby/core_ext'
require 'bundler'
# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] = File.join(GAME_ROOT_PATH, 'Gemfile')

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require(:default, :development) if defined?(Bundler)

$CLASSPATH << File.join(GAME_ROOT_PATH, "java", "classes")
$: << File.join(GAME_ROOT_PATH)

require 'jmonkeyengine/testdata'
include JMonkeyEngine::TestData

require 'jmonkeyengine'
