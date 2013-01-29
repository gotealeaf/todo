class Todo < ActiveRecord::Base
  has_many :tags
end
