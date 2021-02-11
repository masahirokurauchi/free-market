class CategoriesController < ApplicationController
  def index
  end

  def show
  	@category = Category.find(params[:id])
  	@items = Item.search_by_categories(@category.subtree_ids)
  end
end
