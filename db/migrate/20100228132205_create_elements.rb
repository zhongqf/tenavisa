class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.integer :position
      t.string :key
      t.string :title_cn
      t.string :title_jp
      t.string :kind
      t.text :description
      t.text :params
      t.boolean :enabled
      t.text :validation_script

      t.timestamps
    end
  end

  def self.down
    drop_table :elements
  end
end
