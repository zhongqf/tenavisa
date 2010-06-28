class AddPageIntoElements < ActiveRecord::Migration
  def self.up
    add_column :elements, :page_id, :integer
  end

  def self.down
    remove_column :elements, :page_id
  end
end
