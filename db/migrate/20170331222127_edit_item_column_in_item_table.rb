class EditItemColumnInItemTable < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :items, :item, :item_desc
  end

end
