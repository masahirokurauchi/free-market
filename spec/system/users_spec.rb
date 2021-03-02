require 'rails_helper'

RSpec.describe "Users", type: :system do
  # before do
  #   driven_by(:rack_test)  ## ブラウザを起動しない形式のテストにする
  # end

  context 'SNS認証' do
    it 'Google認証をすると、新規登録画面で既に情報が入力済みになっている' do
      # トップページに移動する
      visit root_path
      # トップページに登録方法の選択ページへ遷移するリンクがある
      expect(page).to have_content('新規会員登録')

      # 登録方法の選択ページへ遷移する
      visit users_select_path
      # Google認証へのリンクがある
      expect(page).to have_content('Googleで登録する')
      # Google認証へのリンクをクリックする
      find('.button', text:"Googleで登録する").click
      binding.pry
    end  ## /it 'Google認証をすると、新規登録画面で既に情報が入力済みになっている'
  end  ## /context 'SNS認証' do

end  ## /RSpec.describe "Users"