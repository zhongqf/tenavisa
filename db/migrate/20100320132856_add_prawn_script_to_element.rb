class AddPrawnScriptToElement < ActiveRecord::Migration
  def self.up
    add_column :elements, :prawn_output_script, :text
  end

  def self.down
    remove_column :elements, :prawn_output_script
  end
end
