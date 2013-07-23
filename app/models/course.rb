class Course < ActiveRecord::Base
  belongs_to :enrollment
  delegate :students, :to => :enrollment
  alias_attribute :course_name, :name
end