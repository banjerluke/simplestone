require File.dirname(__FILE__) + '/../sandstone_test_helper'

class PageVariableTest < Test::Unit::TestCase
  should_belong_to :page
  should_require_attributes :name, :content
end
