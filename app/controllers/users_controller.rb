class UsersController < ApplicationController

	def show
		@selling_items = current_user.selling_items
		@bought_items = current_user.bought_items
		
	end
end
