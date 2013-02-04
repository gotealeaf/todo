class Todo < ActiveRecord::Base
  has_many :tags
  validates_presence_of :name

  def name_only?
    description.blank?
  end
end
