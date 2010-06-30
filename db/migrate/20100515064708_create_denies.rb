class CreateDenies < ActiveRecord::Migration
  def self.up
    create_table :denies do |t|
      t.integer :profile_id
      t.integer :educator_id
      t.text :reason

      t.timestamps
    end
  end

  def self.down
    drop_table :denies
  end
end
