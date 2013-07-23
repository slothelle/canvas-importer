class Student < ActiveRecord::Base
  belongs_to :enrollment

  delegate :courses, :to => :enrollment

  alias_attribute :user_name, :name

  validates_presence_of :name, :user_id, :state
end