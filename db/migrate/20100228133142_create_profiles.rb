class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :student_id
      t.text :status

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
