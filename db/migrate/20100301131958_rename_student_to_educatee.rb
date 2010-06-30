class RenameStudentToEducatee < ActiveRecord::Migration
  def self.up
    rename_table :students, :educatees
  end

  def self.down
    rename_table :educatees, :students
  end
end
