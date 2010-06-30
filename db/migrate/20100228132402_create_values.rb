class CreateValues < ActiveRecord::Migration
  def self.up
    create_table :values do |t|
      t.integer :student_id
      t.integer :element_id
      t.string :element_key
      t.text :value

      t.timestamps
    end
  end

  def self.down
    drop_table :values
  end
end
