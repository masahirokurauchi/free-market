# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :check_recaptcha, only: [:create]
  before_action :session_has_not_user, only: [:confirm_phone, :new_address, :create_address]
  layout 'no_menu'

  # GET /resource/sign_up
  def new
    @progress = 1
    if session["devise.sns_auth"]
      ## session["devise.sns_auth"]がある＝sns認証
      build_resource(session["devise.sns_auth"]["user"])
      ## ビューのパスワード欄を隠すため
      @sns_auth = true
    else
      ## session["devise.sns_auth"]がない=sns認証ではない
      super
    end
  end

  # POST /resource
  def create
    if session["devise.sns_auth"]
    ## SNS認証でユーザー登録をしようとしている場合
    ## パスワードが未入力なのでランダムで生成する
    password = Devise.friendly_token[8,12] + "1a"
    ## 生成したパスワードをparamsに入れる
    params[:user][:password] = password
    params[:user][:password_confirmation] = password
    end

    
    ## @user = User.new(user_params)のイメージ
    build_resource(sign_up_params)

    ##バリデーションチェック
    unless resource.valid?
      @progress = 1
      @sns_auth = true if session["devise.sns_auth"]
      flash.now[:alert] = resource.errors.full_messages
      render :new and return
    end

    session["devise.user_object"] = @user.attributes  ##sessionにハッシュ形式で値を入れる
    session["devise.user_object"][:password] = params[:user][:password]  ## 暗号化前のパスワードをsessionに入れる
    respond_with resource, location: after_sign_up_path_for(resource)  ## リダイレクト

    # ## ↓resource（@user）にsns_credentialを紐付けている
    # resource.build_sns_credential(session["devise.sns_auth"]["sns_credential"]) if session["devise.sns_auth"]

    # if resource.save  ## @user.save をしているイメージ
    #   set_flash_message! :notice, :signed_up  ## フラッシュメッセージのセット
    #   sign_up(resource_name, resource)  ## 新規登録＆ログイン
    #   respond_with resource, location: after_sign_up_path_for(resource)  ## リダイレクト
    # else
    #   redirect_to new_user_registration_path, alert: @user.errors.full_messages
    # end

  end

  def select
    session.delete("devise.sns_auth")
    @auth_text = "で登録する"
  end

  def confirm_phone
    @progress = 2
    binding.pry
  end

  def new_address
    @progress = 3

    @address = Address.new
  end

  def create_address
    @address = Address.new(address_params)
    @progress = 5

    unless @address.valid?
      @progress = 3
      redirect_to users_new_address_path, alert: @address.errors.full_messages
    end

    @progress = 5
    ## User.newのイメージ
    @user = build_resource(session["devise.user_object"])
    @user.build_sns_credential(session["devise.sns_auth"]["sns_credential"]) if session["devise.sns_auth"] ##sns認証でここまできたとき
    @user.address = @address

    if @user.save
      sign_up(resource_name, resource)  ## ログインさせる
    else
      redirect_to root_path, alert: @user.errors.full_messages
    end

    # unless @address.save
    #   redirect_to users_new_address_path, alert: @address.errors.full_messages
    # end
  end

  def completed
    @progress = 5
  end




  private

  def after_sign_up_path_for(resource)
    users_confirm_phone_path
  end

  def check_recaptcha
    redirect_to new_user_registration_path unless verify_recaptcha(message: "reCAPTCHAを承認してください")
  end

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
  end

  def session_has_not_user
    redirect_to new_user_registration_path, alert: "会員情報を入力してください。" unless session["devise.user_object"].present?
  end

end
