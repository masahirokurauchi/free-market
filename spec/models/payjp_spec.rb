require 'rails_helper'

RSpec.describe Card, type: :model do
  describe "クラスメソッドのテスト" do

    context "正しいカード情報が送られている" do

      let(:user) { FactoryBot.create(:user) }

      ## card_token = cardモデルのオブジェクト
      let(:card_token) { FactoryBot.create(:card_token, user: user ) }

      it "card_tokenオブジェクト本来の挙動" do
        puts "ーーーーーーーーーーーーーーーー"
        puts "カスタマーのトークン"
        puts card_token.customer_token
        puts "カードのトークン"
        puts card_token.card_token
        puts "ーーーーーーーーーーーーーーーー"
      end  ## /it "card_tokenオブジェクト本来の挙動"
      
      ## モックの実装
      it "モックとallowの挙動確認" do
        test_mock = double("TestMock") ## doubleで作られるモックオブジェクトは本来の返り値の代用品であり、ただの身代わりのようなもの.

        dummy_card_token = "car_abcdefghijklmnopqrstuvwxyz"

        ## card_tokenオブジェクトに対してcustomer_tokenメソッドを実行した時、代わりにtest_mockを返す
        allow(card_token).to receive(:customer_token).and_return(test_mock)

        ## card_tokenオブジェクトに対してcard_tokenメソッドを実行した時、代わりにdummy_card_tokenを返す
        allow(card_token).to receive(:card_token).and_return(dummy_card_token)

        ## test_mockに対してhelloメソッドを実行した時、代わりに"こんにちわ"を返す
        allow(test_mock).to receive(:hello).and_return("こんにちわ")

        puts "ーーーーーーーーーーーーーーーー"
        puts "カスタマーのトークン"
        puts card_token.customer_token
        puts "\nカードのトークン"
        puts card_token.card_token
        puts "\ntest_mockが挨拶をします"
        puts card_token.customer_token.hello
        puts "ーーーーーーーーーーーーーーーー"
      end  ## /it "モックとallowの挙動確認" 

    end  ## /context "正しいカード情報が送られている"

  end  ## /describe "クラスメソッドのテスト"

end  ## /RSpec.describe Card