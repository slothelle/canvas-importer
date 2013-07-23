class AddUniqueIndexToStudents < ActiveRecord::Migration
  def change
    add_index :students, :user_id, unique: true
  end
end