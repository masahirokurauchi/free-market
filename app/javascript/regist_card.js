document.addEventListener('turbolinks:load', function () {
  if (!$('#card_form')[0]) return false; //カード登録ページではないなら以降実行しない。
  
  Payjp.setPublicKey("pk_test_9993b7a16e4609ddc21ad47f"); //公開鍵を読み込む。

  const regist_button = $("#regist_card"); //カード入力フォームの登録ボタン。

  //登録ボタンを押したとき
  regist_button.on("click", function (e) { //登録ボタンを押したとき（ここはsubmitではなくclickにしておく）。
      e.preventDefault(); //デフォルトで発動するフォームの送信を防ぐ
   
      const card = {
          number: $("#card_number_form").val(),
          cvc: $("#cvc_form").val(),
          exp_month: $("#exp_month_form").val(),
          exp_year: Number($("#exp_year_form").val()) + 2000 //4桁である必要があるため
      };
    　
    Payjp.createToken(card, (status, response) => { //cardをpayjpに送信して登録する。
      
        if (status === 200) { //成功した場合
          alert("カードを登録しました");
          
          // ↓hidden_fieldにcardのtokenを入れることでtokenがparamsに送られる。
	      $("#card_token").append(
	        `<input type="hidden" name="payjp_token" value=${response.id}>
	        <input type="hidden" name="card_token" value=${response.card.id}>`
	      );

	      // ↓formのsubmitボタンを強制起動する（ページが遷移してコントローラが起動する）。
          $('#card_form')[0].submit();
        } else { //失敗した場合
          alert("カード情報が正しくありません。");
          console.log(response.error.message);
          regist_button.prop('disabled', false);
        }

      });
    }); 
});