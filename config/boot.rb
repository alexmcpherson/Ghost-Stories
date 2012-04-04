require 'bundler'

Bundler.setup

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require './app'