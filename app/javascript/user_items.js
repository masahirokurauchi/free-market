document.addEventListener('turbolinks:load', function () {
  if (!$('.mypage-block')[0]) return false; //ユーザーマイページではないなら以降実行しない。
  

  $(".mypage-block-tabs__tab").on("click", function (e) {　//　出品中ボタンが押された時
    e.preventDefault(); //デフォルトで発動するリンクの遷移を防ぐ

    let condition = $(this).attr('id') // idを取得する

    let ajax_url = "";

    if (condition == "selling") { // 出品商品　出品中ボタンなら
      ajax_url = "/users/selling"
      console.log("selling");

    } else if (condition == "selling_progress") { // 出品商品　取引中ボタンなら
      ajax_url = "/users/selling_progress"
    
      console.log("selling_progress");

    } else if (condition == "sold") { // 出品商品　売却済みボタンなら
      ajax_url = "/users/sold"
      console.log("sold")

    } else if (condition == "bought_progress") { // 購入商品　取引中ボタンなら
      ajax_url = "/users/bought_progress"
      console.log("bought_progress")

    } else if (condition == "bought_past") { // 購入商品　過去の取引ボタンなら
      ajax_url = "/users/bought_past"
      console.log("bought_past")

    }

    $.ajax({ //AJAXでuser/sellingを動かす
        url: ajax_url,
        type: "GET",
        dataType: 'json',
      }).done(function (items) {
        if (items.length == 0) return false //categoryが空、つまり孫が選択された場合、処理を終了させる。
          items.forEach(function (item) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
           console.log(item.image)
          });

        // changed_form.nextAll(".select-category").remove(); //選択肢たカテゴリ以降のカテゴリを全て消去。カテゴリの選び直し対策。

        // const html = buildCategoryForm(categories);// カテゴリのフォームを組み立てる
        // $(".select-category:last").after(html);// 組み立てたフォームを表示
      })
      .fail(function () {
        alert('error');
      })
    

  });
  
});