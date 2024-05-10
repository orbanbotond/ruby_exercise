require 'rubygems'
require 'bundler/setup'

require 'active_model'
require 'action_view'
require 'rails'

Bundler.require(:default)

require 'support/stub_class'
require 'active_support/core_ext/object/blank.rb'
require 'dry/monads/result'
require 'dry/monads/do/all'
require 'dependency'
require 'initializer'
require 'configure'
