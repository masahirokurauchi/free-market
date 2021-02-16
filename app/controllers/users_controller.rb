class UsersController < ApplicationController

	def show
		@items = current_user.selling_items
		@bought_items = current_user.bought_items
	end

	def selling
		@items = current_user.selling_items
		
	end

	def selling_progress
		
	end

	def sold
		
	end

	def bought_progress
		
	end

	def bought_past
		
	end
end
