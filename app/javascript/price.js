document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //商品出品ページでないなら以降実行しない。


  $("#item_price").on("keyup", function () { //価格が入力された時

    $("#fee").text(""); //以前の手数料を削除
    $("#profit").text(""); //以前の利益を削除

    $("#price-error").text("");

    let price = $(this).val(); //価格を取得
    

    if ($.isNumeric(price)) { //　数字かつ３００円以上なら
      if ((price >= 300) && (price <= 9999999)) { //　数字かつ３００円以上なら
        $("#price-error").text();

        let fee = Math.round(price / 10); //手数料を計算
        let profit = price - fee //利益を計算
        
        $("#fee").text(fee); //手数料を表示
        $("#profit").text(profit); //利益を表示

      } else { // 数字かつ３００円以下か９９９９９９９円以上なら
        $("#price-error").text("300~9,999,999円以下にしてください");
      }

    } else { // 数字でないなら
         $("#price-error").text("数字を入力してください");

    }

    
  });
});