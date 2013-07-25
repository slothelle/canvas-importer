class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :students, :through => :enrollments

  alias_attribute :course_name, :name

  validates_presence_of :name, :course_id, :state

  scope :that_is_active, -> { where(state: 'active') }
end