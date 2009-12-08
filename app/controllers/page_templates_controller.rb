class PageTemplatesController < ApplicationController
  unloadable
  layout 'simplestone'
  include Sandstone::Controllers::PageTemplates
  
  before_filter :require_sandstone_editor, :except => :show
end
