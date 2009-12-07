class PageTemplatesController < ApplicationController
  unloadable
  layout 'sandstone'
  include Sandstone::Controllers::PageTemplates
  
  before_filter :require_sandstone_editor, :except => :show
end
