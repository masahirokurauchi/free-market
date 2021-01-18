# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :check_recaptcha, only: [:create]
  layout 'no_menu'

  # GET /resource/sign_up
  def new
    if session["devise.sns_auth"]
      ## session["devise.sns_auth"]がある＝sns認証
      build_resource(session["devise.sns_auth"][:user])
    else
      ## session["devise.sns_auth"]がない=sns認証ではない
      super
    end
  end

  # POST /resource
  def create
    if params[:user][:sns_auth]
    ## SNS認証でユーザー登録をしようとしている場合
    ## パスワードが未入力なのでランダムで生成する
    password = Devise.friendly_token[8,12] + "1a"
    ## 生成したパスワードをparamsに入れる
    params[:user][:password] = password
    params[:user][:password_confirmation] = password
    end
  
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def select
    @auth_text = "で登録する"
  end

  def confirm_phone
  end

  def new_address
  end

  def completed
  end

  private

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def check_recaptcha
    redirect_to new_user_registration_path unless verify_recaptcha(message: "reCAPTCHAを承認してください")
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
