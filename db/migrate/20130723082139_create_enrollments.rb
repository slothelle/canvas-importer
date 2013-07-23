class CreateEnrollments < ActiveRecord::Migration
  def up
    create_table :enrollments do |t|
      t.references :student, null: false
      t.references :course, null: false
      t.string :state, null: false
      t.timestamps
    end
  end

  def down
    drop_table :enrollments
  end
end