class UsersController < ApplicationController

	def show
		@items = current_user.selling_items
		@bought_items = current_user.bought_items
		@bought_active = 1
	end

	def selling
		@items = Item.where(seller_id: current_user.id, deal: 0).includes(:images)
	end

	def selling_progress
		@items = Item.where(seller_id: current_user.id, deal: 0).includes(:images)
	end

	def sold
		@items = Item.where(seller_id: current_user.id, deal: 1).includes(:images)
	end

	def bought_progress
	end

	def bought_past
	end
end
