class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :card_is_registered?, except: [:index, :destroy]

  def index
    @card = Card.get_card(current_user.card.customer_token) if current_user.card
  end

  def new
    @card = Card.new
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key] ## APIキーの取得

    customer = Payjp::Customer.create(card: params[:payjp_token]) ## 顧客の作成

    card = current_user.build_card(card_token: params[:card_token], customer_token: customer.id)

    if card.save
      redirect_to cards_path, notice: "カードの登録が完了しました。"
    else
      redirect_to new_card_path, alert: "カードの登録に失敗しました。"
    end
  end

  def destroy
    card = current_user.card

    if card.destroy
      redirect_to cards_path, notice: "カードの削除が完了しました。"
    else
      redirect_to cards_path, notice: "カードの削除に失敗しました。"
    end

  end

  private

  def card_is_registered?
  	redirect_to root_path, notice: "カードは登録済みです。" if current_user.card.present?
  end

end
