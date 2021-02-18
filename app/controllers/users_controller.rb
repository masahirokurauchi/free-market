class UsersController < ApplicationController

	def show
		@items = current_user.selling_items
		@bought_items = current_user.bought_items
		@selling_active = 1
		@bought_active = 1
	end

	def selling
		@items = current_user.selling_items.includes(:images)
	end

	def selling_progress
		@selling_active = 2
	end

	def sold
		@selling_active = 3
	end

	def bought_progress
		@bought_active = 1
	end

	def bought_past
		@bought_active = 2
	end
end
