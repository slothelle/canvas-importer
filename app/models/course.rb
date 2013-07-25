class Course < ActiveRecord::Base
  has_many :enrollments

  alias_attribute :course_name, :name

  validates_presence_of :name, :course_id, :state

  scope :that_is_active, -> { where(state: 'active') }
end