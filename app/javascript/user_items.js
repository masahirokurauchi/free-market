document.addEventListener('turbolinks:load', function () {
  if (!$('.mypage-block')[0]) return false; //ユーザーマイページではないなら以降実行しない。

  function builditems(items, active_id) { // 商品の一覧を組み立てる
    let options = "";

    if (active_id == 1 || active_id == 2 || active_id == 3) { //出品商品の場合
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
                            <img src =${item.image} alt ="image" class ="item-data__image">
                            <div class="item-data__detail">
                              「
                              ${item.name}
                              」
                              ${item.detail}
                            </div>
                            <img src ="/assets/icon-arrow-ffd4a8f478b85be67159e2805ddce1ab337dfabcae57d013392b873f3f06495f.png" class ="item-data__arrow">
                          </div>
                        </div>
                      </a>
                     `;
        });
      } 
    } else { //購入商品の場合

    }

    let selling_active, selling_progress_active, sold_active = "";

    if (active_id == 1) {
      selling_active = "active-tab"
    } else if (active_id == 2) {
      selling_progress_active = "active-tab"
    } else if (active_id == 3) {
      sold_active = "active-tab"
    }

    const html = `
                  <div id ="selling-tabs" class ="mypage-block-tabs">
                    <a id="selling" class="mypage-block-tabs__tab ${selling_active}">
                      出品中
                    </a>
                    <a id="selling_progress" class="mypage-block-tabs__tab ${selling_progress_active}">
                      取引中
                    </a>
                    <a id="sold" class="mypage-block-tabs__tab ${sold_active}">
                      売却済み
                    </a>
                  </div>
                  <div id="selling-items-tabs" class ="mypage-block-data-list">
                    ${options}
                  </div>
                 `;
    return html;
  }
  

  // $(".mypage-block-tabs__tab").on("click", function (e) {　//　出品中ボタンが押された時
  $(document).on("click", ".mypage-block-tabs__tab", function (e) {//　出品中ボタンが押された時
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

        if (active_id == 1 || active_id == 2 || active_id == 3) { //出品商品の場合
          $("#selling-tabs").remove(); //タブの消去
          $("#selling-items-tabs").remove(); //商品の消去

          const html = builditems(items, active_id);// 商品を組み立てる
          $(".mypage-block-header-user").after(html);// 組み立てたフォームを表示

        } else { //購入商品の場合
          $("#bought-tabs").remove(); //タブと商品の消去

          // const html = builditems(items, active_id);// 商品を組み立てる
        }

        
      })
      .fail(function () {
        alert('error');
      })
    

  });
  
});