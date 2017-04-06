class WelcomeController < ApplicationController
	def index
		@latest_orders = Order.order(created_at: :desc).limit(5)
	end
end
