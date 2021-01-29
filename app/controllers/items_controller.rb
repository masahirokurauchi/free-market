class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only:[:edit, :update, :destroy]
  before_action :seller?, only:[:edit, :update, :destroy]

  def new
  	@item = Item.new
    3.times do
      @item.images.build
    end
    render layout: 'no_menu'
  end

  def create
  	@item = Item.new(item_params)
  	if @item.save
      redirect_to root_path, notice: "出品に成功しました"
    else
      redirect_to new_item_path, alert: @item.errors.full_messages
    end
  end

  def edit
  	@item.images.build
    render layout: 'no_menu'
  end

  def update
  	if @item.update(item_params)
  		redirect_to root_path, notice: "商品の編集が完了しました。"
  	else
  		redirect_to edit_item_path(@item), alert: @item.errors.full_messages
  	end
  end

  def destroy
  	if @item.destroy
  		redirect_to root_path, notice: "商品の削除が完了しました。"
  	else
  		render layout: 'no_menu', action: :edit
  	end
  end

  def purchase_confirmation
    render layout: 'no_menu'
  end


  private
  def item_params
  	params.require(:item).permit(:name, :detail, :category_id, :condition, :delivery_fee_payer, :delivery_method, :prefecture_id, :delivery_days, :price, images_attributes: [:src, :id, :_destroy]).merge(seller_id: current_user.id)
  end

  def set_item
  	@item = Item.find(params[:id])
  end

  def seller?
  	redirect_to root_path, notice: "あなたは出品者ではありません。" unless current_user.id == @item.seller_id
  end
end
