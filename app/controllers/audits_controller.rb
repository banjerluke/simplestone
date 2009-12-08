class AuditsController < ApplicationController
  unloadable
  layout 'simplestone'
  include Sandstone::Controllers::Audits
  
  before_filter :require_sandstone_manager
end
