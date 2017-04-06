class AddOrderColumnToOrdertable < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :waiting, :boolean, :default => true
  end
end
