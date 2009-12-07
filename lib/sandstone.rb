puts "loading sandstone"

lib_dir = File.join(File.dirname(__FILE__))
Dir.glob([File.join(lib_dir,"sandstone/*.rb"), File.join(lib_dir,"sandstone/**/*.rb")]).each {|file| require file }
