require 'sandstone'
require 'acts_as_versioned'
require 'acts_as_tree'
require 'dispatcher'

Dispatcher.to_prepare do
  ApplicationController.send(:include, SandstoneSystem)
end