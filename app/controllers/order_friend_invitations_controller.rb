class OrderFriendInvitationsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	#before_action :set_order_friend_invitation, only: [:show, :edit, :update, :destroy]

	def index
		@user = User.find(params[:user_id])
		@order = @user.orders.find(params[:order_id])
		@invited_friends = @order.order_friend_invitations
		@invited_friends_ids = []
		@invited_friends.each do |inv|
			@invited_friends_ids << inv.user_id.to_i
		end
		@invited_friends = User.where(id: @invited_friends_ids)
	end

	def joined
		@user = User.find(params[:user_id])
		@order = @user.orders.find(params[:order_id])
		@joined_friends = @order.order_friend_invitations.where("pending=?", false)
		@joined_friends_ids = []
		@joined_friends.each do |inv|
			@joined_friends_ids << inv.user_id.to_i
		end
		@joined_friends = User.where(id: @joined_friends_ids)
		#render plain: @joined_friends.inspect
	end

	def new
		#@user = User.find(params[:user_id])
		@order = current_user.orders.find(params[:order_id])
		@order_friend_invitation = @order.order_friend_invitations.new
	end


	def create
		@invited_friends = params[:invited_friends]
		#render plain: @invited_friends.inspect
		@invited_friends.each do |invited_friend_id|
			#render plain: invited_friend_id.inspect
			@order_friend_invitation = current_user.orders.find(params[:order_id]).order_friend_invitations.build(:user_id => invited_friend_id)
	  		@order_friend_invitation.save
	  		Message.create(body: "#{current_user.name} invited you to order <a href='https://serene-temple-30674.herokuapp.com/users/#{current_user.id}/orders/#{params[:order_id]}/order_friend_invitations/join?id=#{@order_friend_invitation.id}' target='_blank'>join</a>", msgid: invited_friend_id)
	  end
	  redirect_to user_order_order_friend_invitations_path
	  # if @order_friend_invitation.save
	  #   flash[:notice] = "Invited friend."
	  #   redirect_to root_url
	  # else
	  #   flash[:notice] = "Unable to invite friend."
	  #   redirect_to root_url
	  # end
	end

	def uninvite
		@order = current_user.orders.find(params[:order_id])
		@order_friend_invitation_id = @order.order_friend_invitations.where("user_id = ?", params[:invited_friend_id]).first.id
		OrderFriendInvitation.destroy(@order_friend_invitation_id)
		redirect_to user_order_order_friend_invitations_path
	end

	def join
		@order_friend_invitation = OrderFriendInvitation.find(params[:id])
		@order_friend_invitation.update_attribute(:pending, false)
		@order = Order.find(@order_friend_invitation.order_id)
	    Message.create(body: "#{current_user.name} joined your <a href=https://serene-temple-30674.herokuapp.com/users/#{@order.user_id}/orders/#{@order_friend_invitation.order_id}' target='_blank'>order</a>", msgid: @order.user_id)
		redirect_to user_orders_path
	end

end
