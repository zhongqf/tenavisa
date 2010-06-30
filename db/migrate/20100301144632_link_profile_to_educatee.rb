class LinkProfileToEducatee < ActiveRecord::Migration
  def self.up
    rename_column :profiles, :student_id, :educatee_id
  end

  def self.down
    rename_column :profiles, :educatee_id, :student_id
  end
end
