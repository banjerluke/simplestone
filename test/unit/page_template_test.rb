require File.dirname(__FILE__) + '/../sandstone_test_helper'

class PageTemplateTest < Test::Unit::TestCase
  should_have_many :pages
  should_require_attributes :name
  should_require_unique_attributes :name

  def setup
    create_page_template!(:content => 'eephus')
  end

  # hits the database, mocks the filesystem
  def test_file_should_be_created_with_record
    template = PageTemplate.new :name => 'tester', :content => 'eephus'
    File.expects(:open).with(template.send(:layout_filename), 'wb+')
    template.save
  end
end
