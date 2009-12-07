class SitemapsController < ApplicationController
  unloadable
  layout 'public'
  include Sandstone::Controllers::Sitemaps
end
