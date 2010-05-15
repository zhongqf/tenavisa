# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100515055821) do

  create_table "accounts", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.integer  "loginable_id"
    t.string   "loginable_type"
    t.datetime "password_expires_at",                      :default => '9999-12-31 23:59:59'
  end

  add_index "accounts", ["login"], :name => "index_accounts_on_login", :unique => true

  create_table "educatees", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "educators", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_operator"
  end

  create_table "elements", :force => true do |t|
    t.integer  "position"
    t.string   "key"
    t.string   "title_cn"
    t.string   "title_jp"
    t.string   "kind"
    t.text     "description"
    t.text     "params"
    t.boolean  "enabled"
    t.text     "validation_script"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id"
    t.text     "prawn_output_script"
    t.boolean  "is_title"
    t.integer  "display_index"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "educatee_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_configs", :force => true do |t|
    t.string   "profile_pdf_template_file_name"
    t.string   "profile_pdf_template_content_type"
    t.integer  "profile_pdf_template_file_size"
    t.datetime "profile_pdf_template_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "system_activation_mailtext"
    t.text     "system_register_mailtext"
    t.text     "profile_submit_mailtext"
    t.text     "profile_deny_mailtext"
    t.text     "profile_accept_mailtext"
    t.text     "profile_register_mailtext"
  end

  create_table "typus_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "valeurs", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "element_id"
    t.string   "element_key"
    t.text     "valeur"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
