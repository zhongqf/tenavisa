class CreateSystemConfigs < ActiveRecord::Migration
  def self.up
    create_table :system_configs do |t|
      t.string :profile_pdf_template_file_name
      t.string :profile_pdf_template_content_type
      t.integer :profile_pdf_template_file_size
      t.datetime :profile_pdf_template_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :system_configs
  end
end
