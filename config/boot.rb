require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] = File.join(GAME_ROOT_PATH, 'Gemfile')

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])