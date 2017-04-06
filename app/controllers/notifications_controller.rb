class NotificationsController < ApplicationController
  def index
  	#@notifications = Notification.all.reverse
  	@notifications = Notification.where("user_id=?", current_user.id).reverse
  end
end
