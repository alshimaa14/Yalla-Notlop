class AddStatusColumnToOrderFriendInvitationTable < ActiveRecord::Migration[5.0]
  def change
    add_column :order_friend_invitations, :pending, :boolean, :default => true
  end
end
