class UsersController < ApplicationController

	def show
		@items = current_user.selling_items
		
	end
end
