class UpdateProfileStatusToString < ActiveRecord::Migration
  def self.up
    change_column :profiles, :status, :string
  end

  def self.down
    change_column :profiles, :status, :text
  end
end
