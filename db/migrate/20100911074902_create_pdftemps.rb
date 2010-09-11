class CreatePdftemps < ActiveRecord::Migration
  def self.up
    create_table :pdftemps do |t|
      t.string :key
      t.string :title
      t.string :pdffile_file_name
      t.string :pdffile_content_type
      t.integer :pdffile_file_size
      t.datetime :pdffile_updated_at
      t.text :script

      t.timestamps
    end
  end

  def self.down
    drop_table :pdftemps
  end
end
