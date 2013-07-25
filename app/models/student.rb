class Student < ActiveRecord::Base
  has_many :enrollments

  alias_attribute :user_name, :name

  validates_presence_of :name, :user_id, :state
end