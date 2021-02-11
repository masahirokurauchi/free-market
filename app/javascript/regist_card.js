document.addEventListener('turbolinks:load', function () {
  if (!$('#card_form')[0]) return false; //カード登録ページではないなら以降実行しない。
  
  Payjp.setPublicKey("pk_test_9993b7a16e4609ddc21ad47f"); //公開鍵を読み込む。

  const regist_button = $("#regist_card"); //カード入力フォームの登録ボタン。

  //登録ボタンを押したとき
  regist_button.on("click", function (e) { //登録ボタンを押したとき（ここはsubmitではなくclickにしておく）。
      e.preventDefault();
   
      const card = {
          number: $("#card_number_form").val(),
          cvc: $("#cvc_form").val(),
          exp_month: $("#exp_month_form").val(),
          exp_year: $("#exp_year_form").val()
      };
    　console.log(card);
    }); 
});