class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  delegate :course_id, :to => :course, :as => :actual_course_id
  delegate :user_id, :to => :student, :as => :actual_student_id

  validates_presence_of :student, :course, :state
  validates_uniqueness_of :student_id, :scope => :course_id
end