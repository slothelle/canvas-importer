class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :courses, :through => :enrollments

  alias_attribute :user_name, :name

  validates_presence_of :name, :user_id, :state
end