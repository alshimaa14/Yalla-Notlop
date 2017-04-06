class AddAttachmentMenuToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.attachment :menu
    end
  end

  def self.down
    remove_attachment :orders, :menu
  end
end
