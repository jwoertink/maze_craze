require 'rubygems'
require 'java'
require 'jruby/core_ext'
require 'bundler'
Bundler.require if defined?(Bundler)

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] = File.join(GAME_ROOT_PATH, 'Gemfile')

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

$CLASSPATH << File.join(GAME_ROOT_PATH, "java", "classes")
$: << File.join(GAME_ROOT_PATH)

require 'vendor/jme3.jar'