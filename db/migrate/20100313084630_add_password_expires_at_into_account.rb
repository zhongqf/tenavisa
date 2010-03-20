class AddPasswordExpiresAtIntoAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :password_expires_at, :datetime, :default => "9999/12/31 23:59:59"
  end

  def self.down
    remove_column :accounts, :password_expires_at
  end
end
