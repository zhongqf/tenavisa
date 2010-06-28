class AddIsOperatorIntoEducator < ActiveRecord::Migration
  def self.up
    add_column :educators, :is_operator, :boolean
  end

  def self.down
    remove_column :educators, :is_operator
  end
end
