class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only:[:edit, :update, :destroy, :show, :purchase_confirmation, :purchase]
  before_action :seller?, only:[:edit, :update, :destroy]
  before_action :sold_item?, only:[:edit, :update, :destroy, :purchase_confirmation, :purchase]
  before_action :user_is_seller?, only:[:purchase_confirmation, :purchase]

  def index
  	return false if Item.count == 0 ## 商品数がゼロのときはランキングが作れないのでここで終了
    categories = Category.roots ## 親カテゴリたちを配列で取得
    items = categories.map{|root| Item.search_by_categories(root.subtree_ids)} ## カテゴリごとの商品リストを取得
    @sorted_items = items.sort { |a,b| b.length <=> a.length} ## カテゴリごとの商品リストを商品数が多い順で並び替える
    @sorted_items = @sorted_items[0..3].map{|items| items.order("created_at DESC").limit(4)} ## 商品数が多いカテゴリ上位4つのみ表示したい。また、1つのカテゴリのうち新着商品は4つだけ表示する。
    @sorted_items = @sorted_items.reject(&:blank?) ## 商品数がゼロのカテゴリを削除する
    @category_ranking = @sorted_items.map{|items| items[0].category.root} ## 商品数が多いカテゴリのランキングを定義
  	
  end

  def show
  end

  def new
  	@item = Item.new
    @item.images.build
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
  	@card = Card.get_card(current_user.card.customer_token) if current_user.card
    render layout: 'no_menu'
  end

  def purchase
  	redirect_to cards_path, alert: "クレジットカードを登録してください" and return unless current_user.card.present?

  	Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer_token = current_user.card.customer_token

    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客、もしくはカードのトークン
      currency: 'jpy'  # 通貨の種類
    )

    @item.update(deal: "売り切れ")

    redirect_to item_path(@item), notice: "商品を購入しました"
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

  def sold_item?
  	redirect_to root_path, alert: "売り切れです" if @item.deal != "販売中"
  end

  def user_is_seller?
  	redirect_to root_path, alert: "自分で出品した商品は購入できません" if @item.seller_id == current_user.id
  end
end
