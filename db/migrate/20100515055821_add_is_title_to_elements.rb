class AddIsTitleToElements < ActiveRecord::Migration
  def self.up
    add_column :elements, :is_title, :boolean
    add_column :elements, :display_index, :integer, :default => 0
  end

  def self.down
    remove_column :elements, :is_title
    remove_column :elements, :display_index
  end
end
