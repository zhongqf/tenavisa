class LinkValueToProfile < ActiveRecord::Migration
  def self.up
    rename_column :values, :student_id, :profile_id
  end

  def self.down
    rename_column :values, :profile_id, :student_id
  end
end
