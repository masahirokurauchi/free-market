document.addEventListener('turbolinks:load', function () {
  if (!$('.mypage-block')[0]) return false; //ユーザーマイページではないなら以降実行しない。

  function builditems(items, active_id) { // 商品の一覧を組み立てる
    let options = "";

    if (active_id == 1 || active_id == 2 || active_id == 3) {
      if (items.length == 0) {
        options = `
                    <div class ="mypage-block-data-list__data-none">
                      <div class ="text">
                        出品中の商品がありません。
                      </div>
                    </div>
                   `;
      } else {

        items.forEach(function (item) { // 商品を一つずつ渡して、一つずつ組み立てていく。
          options += `
                      <a href="/items/${item.id}">
                        <div class ="mypage-block-data-list__data">
                          <div class ="item-data">
                            <img src =${item.image&.src&.url} alt ="image" class ="item-data__image">                        .item-data__detail
                              「
                              ${item.name}
                              」
                              ${item.detail}
                            <img src ="icon-arrow.png" class ="item-data__arrow">
                          </div>
                        </div>
                      </a>
                     `;
        });
      } 
    }

    const html = `
                  <div id ="selling-tabs" class ="mypage-block-tabs">
                    <a id="selling" class="mypage-block-tabs__tab ${ 'active-tab' if active_id == 1 }">
                      出品中
                    </a>
                    <a id="selling_progress" class="mypage-block-tabs__tab ${ 'active-tab' if active_id == 2 }">
                      取引中
                    </a>
                    <a id="sold" class="mypage-block-tabs__tab ${ 'active-tab' if active_id == 3 }">
                      売却済み
                    </a>
                  </div>
                  <div class ="mypage-block-data-list">
                    ${options}
                  </div>
                 `;
    return html;
  }
  

  $(".mypage-block-tabs__tab").on("click", function (e) {　//　出品中ボタンが押された時
    e.preventDefault(); //デフォルトで発動するリンクの遷移を防ぐ

    let condition = $(this).attr('id') // idを取得する

    let ajax_url = ""; //AJAX通信用URL

    let active_id = 0; //アクティブid

    if (condition == "selling") { // 出品商品　出品中ボタンなら
      ajax_url = "/users/selling";
      active_id = 1;
      console.log("selling");

    } else if (condition == "selling_progress") { // 出品商品　取引中ボタンなら
      ajax_url = "/users/selling_progress"
      active_id = 2;
      console.log("selling_progress");

    } else if (condition == "sold") { // 出品商品　売却済みボタンなら
      ajax_url = "/users/sold"
      active_id = 3;
      console.log("sold")

    } else if (condition == "bought_progress") { // 購入商品　取引中ボタンなら
      ajax_url = "/users/bought_progress"
      active_id = 4;
      console.log("bought_progress")

    } else if (condition == "bought_past") { // 購入商品　過去の取引ボタンなら
      ajax_url = "/users/bought_past"
      active_id = 5;
      console.log("bought_past")

    }

    $.ajax({ //AJAXでuser/sellingを動かす
        url: ajax_url,
        type: "GET",
        dataType: 'json',
      }).done(function (items) {
        // if (items.length == 0) return false //itemsが空の場合、処理を終了させる。

          items.forEach(function (item) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
           console.log(item.image)
          });

        const html = builditems(items, active_id);// 商品を組み立てる
        $(".select-category:last").after(html);// 組み立てたフォームを表示

        // changed_form.nextAll(".select-category").remove(); //選択肢たカテゴリ以降のカテゴリを全て消去。カテゴリの選び直し対策。

        // const html = buildCategoryForm(categories);// カテゴリのフォームを組み立てる
        // $(".select-category:last").after(html);// 組み立てたフォームを表示
      })
      .fail(function () {
        alert('error');
      })
    

  });
  
});