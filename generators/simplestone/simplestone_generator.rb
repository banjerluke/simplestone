module Rails
  module Generator
    module Commands
      
      class Create < Base
        def file_add_line_after(file, finder_line, added_line)
          gsub_file(file, Regexp.new('^(\s*' + finder_line + ')\s*$'),
            "\\1\n#{added_line}")
        end
      end
      
      class Destroy < RewindBase
        def file_add_line_after(file, finder_line, added_line)
          gsub_file(
            file, 
            Regexp.new('^(\s*)' + "#{added_line}" + '$'),
            '#\1\2'
          )
        end
      end
    end
  end
end

class SimplestoneGenerator < Rails::Generator::Base

  def manifest
    template_dir = File.join(File.dirname(__FILE__), 'templates')
    
    record do |m|
      # Create directory for cached CMS pages
      m.directory('app/views/pages/generated')
      m.directory('app/views/layouts/generated')

      Dir.chdir(template_dir) do
        #handles javascripts
        %w(javascripts).each do |area|
          m.directory(File.join('public', area))
          Dir.glob(File.join(area, '**', '*')).each do |file|
            m.directory(File.join('public', file)) if File.directory?(file)
            m.file(file, File.join('public', file)) if File.file?(file)
          end
        end

        # Handle CSS
        Dir.glob(File.join('stylesheets','*')).each do |f|
          file = File.basename(f)
          m.file("stylesheets/#{file}", "public/stylesheets/#{file}", :collision => :skip)
        end
      end

      # Handle migrations
      Dir.glob(File.join(template_dir, 'db', 'migrate', '*')).each do |file|
        m.migration_template(
          File.join('db/migrate', File.basename(file)),
          'db/migrate',
          :migration_file_name => File.basename(file, '.rb')
        )
      end
    end
  end
    
end