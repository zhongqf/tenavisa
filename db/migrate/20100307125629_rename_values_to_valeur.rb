class RenameValuesToValeur < ActiveRecord::Migration
  def self.up
    rename_table "`values`", :valeurs
    rename_column :valeurs, :value, :valeur
  end

  def self.down
    rename_column :valeurs, :valeur, :value
    rename_table :valeurs, "`values`"
  end
end
