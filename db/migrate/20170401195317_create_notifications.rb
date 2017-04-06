class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :event
      t.integer :user_id
      
      t.timestamps
    end
  end
end
