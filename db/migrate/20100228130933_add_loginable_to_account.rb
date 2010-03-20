class AddLoginableToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :loginable_id, :integer
    add_column :accounts, :loginable_type, :string
  end

  def self.down
    remove_column :accounts, :loginable_type
    remove_column :accounts, :loginable_id
  end
end
