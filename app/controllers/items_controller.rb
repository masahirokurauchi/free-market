class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new]

  def new
  	@item = Item.new
    render layout: 'no_menu' # レイアウトファイルを指定
  end

  def create
  	@item = Item.new(item_params)
  	if @item.save!
      redirect_to root_path, notice: "出品に成功しました"
    else
      render layout: 'no_menu', template: 'items/new' # レイアウトファイル指定
    end
  end

  def edit
    render layout: 'no_menu' # レイアウトファイル指定
  end

  def purchase_confirmation
    render layout: 'no_menu' # レイアウトファイル指定
  end


  private
  def item_params
  	params.require(:item).permit(:name, :detail, :category_id, :condition, :delivery_fee_payer, :delivery_method, :prefecture_id, :delivery_days, :price).merge(seller_id: current_user.id)
  end
end
