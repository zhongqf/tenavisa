class AddWeightToElement < ActiveRecord::Migration
  def self.up
    add_column :elements, :weight, :float, :default => 0
  end

  def self.down
    remove_column :elements, :weight
  end
end
