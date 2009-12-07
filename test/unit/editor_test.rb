require File.dirname(__FILE__) + '/../sandstone_test_helper'

class EditorTest < Test::Unit::TestCase
  should_require_attributes :user_id
  should_require_unique_attributes :user_id
  should_have_many :pages, :audits

  def setup
    create_editor!(:role => 'author')
  end
end
