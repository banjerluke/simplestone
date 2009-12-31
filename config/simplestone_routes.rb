ActionController::Routing::Routes.draw do |map|
  map.workspace 'editor/home', :controller => 'editors', :action => 'show'
  map.resources :audits
  map.resources :editors
  map.resources :pages
  map.resources :page_templates
  map.resource  :preview
  map.resource  :sitemap
  map.sandstone '*path', :controller => 'pages', :action => 'show'
end
