class AddUniqueIndexToCourses < ActiveRecord::Migration
  def change
    add_index :courses, :course_id, unique: true
  end
end