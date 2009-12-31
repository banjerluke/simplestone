# Make sure the required configuration data is loaded.
defaults = {:user_class => 'User', :user_identifier => :name}
unless defined?(SIMPLESTONE)
  SIMPLESTONE = defaults
  RAILS_DEFAULT_LOGGER.warn "WARNING: SIMPLESTONE constant should be defined in an initializer! Defaulting to #{SIMPLESTONE.inspect}..."
end
[:user_class, :user_identifier].each do |attr|
  unless SIMPLESTONE[attr]
    SIMPLESTONE[attr] = defaults[attr]
    RAILS_DEFAULT_LOGGER.warn "WARNING: SIMPLESTONE[:#{attr}] was not set in an initializer! Defaulting to '#{SIMPLESTONE[attr]}'..."
  end
end

lib_dir = File.join(File.dirname(__FILE__))
Dir.glob([File.join(lib_dir,"simplestone/*.rb"), File.join(lib_dir,"simplestone/**/*.rb")]).each {|file| require file }

# I know, this is *ugly*, but until Rails gives us an elegant way
# of doing this, it's necessary to keep Simplestone's routes from
# overriding the main application routes in config/routes.rb
# 
class ActionController::Routing::RouteSet
  def load_routes_with_simplestone!
    simplestone_routes = File.join(File.dirname(__FILE__), 
                       *%w[.. config simplestone_routes.rb])
    unless configuration_files.include? simplestone_routes
      add_configuration_file(simplestone_routes)
    end
    load_routes_without_simplestone!
  end

  alias_method_chain :load_routes!, :simplestone
end

puts "Simplestone loaded..."