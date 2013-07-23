class AddUniqueIndexToEnrollments < ActiveRecord::Migration
  def up
    add_index :enrollments, [:course_id, :student_id], unique: true
  end
end