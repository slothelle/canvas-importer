class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :name, null: false
      t.string :course_id, null: false
      t.string :state, null: false
      t.timestamps
    end
  end

  def down
    drop_table :courses
  end
end