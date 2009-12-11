class Editor < ActiveRecord::Base
  include Sandstone::Models::Editor
  
  belongs_to :user, :class_name => SIMPLESTONE[:user_class]
end