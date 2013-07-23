class Course < ActiveRecord::Base
  belongs_to :enrollment

  delegate :students, :to => :enrollment

  alias_attribute :course_name, :name

  validates_presence_of :name, :course_id, :state
end