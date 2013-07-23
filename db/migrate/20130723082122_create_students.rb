class CreateStudents < ActiveRecord::Migration
  def up
    create_table :students do |t|
      t.sting :name, null: false
      t.string :user_id, null: false
      t.string :state, null: false
      t.timestamps
    end
  end

  def down
    drop_table :students
  end
end