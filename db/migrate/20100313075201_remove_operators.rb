class RemoveOperators < ActiveRecord::Migration
  def self.up
    drop_table :operators
  end

  def self.down
    create_table "operators", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
