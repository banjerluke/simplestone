
lib_dir = File.join(File.dirname(__FILE__))
Dir.glob([File.join(lib_dir,"simplestone/*.rb"), File.join(lib_dir,"simplestone/**/*.rb")]).each {|file| require file }

puts "Simplestone loaded..."