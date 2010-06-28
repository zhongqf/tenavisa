class AddSystemConfigMailTest < ActiveRecord::Migration
  def self.up
    add_column :system_configs, :system_activation_mailtext, :text
    add_column :system_configs, :system_register_mailtext, :text
    add_column :system_configs, :profile_submit_mailtext, :text
    add_column :system_configs, :profile_deny_mailtext, :text
    add_column :system_configs, :profile_accept_mailtext, :text
    add_column :system_configs, :profile_register_mailtext, :text
  end

  def self.down
    remove_column :system_configs, :profile_register_mailtext
    remove_column :system_configs, :profile_accept_mailtext
    remove_column :system_configs, :profile_deny_mailtext
    remove_column :system_configs, :profile_submit_mailtext
    remove_column :system_configs, :system_register_mailtext
    remove_column :system_configs, :system_activation_mailtext
  end
end
