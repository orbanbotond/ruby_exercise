require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'support/stub_class'
require 'active_support/core_ext/object/blank.rb'
require 'dry/monads/result'
require 'dry/monads/do/all'
