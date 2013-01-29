class Todo < ActiveRecord::Base
  has_many :tags

  def name_only?
    description.blank?
  end
end
