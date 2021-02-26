document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //商品出品ページでないなら以降実行しない。


  $("#item_price").on("keyup", function () { //価格が入力された時

    $("#fee").text();
    $("#profit").text();

    let price = $(this).val();
    

    if ($.isNumeric(price) && (price >= 300) ) { //　数字かつ３００円以上なら
        let fee = Math.round(price / 10);
        let profit = price - fee
        
        $("#fee").text(fee);
        $("#profit").text(profit);
    } else if ($.isNumeric(price)) { // 数字かつ３００円以下なら

    } else { // 数字でないなら

    }

    

    
  });
});