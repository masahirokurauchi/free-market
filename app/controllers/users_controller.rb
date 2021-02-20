class UsersController < ApplicationController

	def show
		@items = Item.where(seller_id: current_user.id, deal: 0).includes(:images)
		@bought_items = Item.where(buyer_id: current_user.id, deal: 0).includes(:images)
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
		@items = Item.where(buyer_id: current_user.id, deal: 0).includes(:images)
	end

	def bought_past
		@items = Item.where(buyer_id: current_user.id, deal: 1).includes(:images)
	end
end
