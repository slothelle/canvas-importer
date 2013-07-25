class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  delegate :state, :to => :course, :prefix => true
  delegate :state, :to => :student, :prefix => true
  delegate :course_id, :to => :course

  validates_presence_of :student, :course, :state
  validates_uniqueness_of :student_id, :scope => :course_id

  scope :that_is_active, -> { where(state: 'active') }
end