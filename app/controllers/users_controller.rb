class UsersController < ApplicationController

	def show
		@selling_items = current_user.selling_items
		@bought_items = current_user.bought_items
	end

	def selling
		
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
