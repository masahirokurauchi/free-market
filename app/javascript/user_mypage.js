document.addEventListener('turbolinks:load', function () {
  if ($('.mypage-block')[0] || !$('.mypage-side-bar-lists__list')[0]) return false; //ユーザーマイページではないなら以降実行しない。


  $(document).on("click", ".mypage-side-bar-lists__list", function (e) {//　サイドバーリストが押された時

    let mypage = $('.mypage-side-bar-lists__list--left')[0];

    let cld = $(this).children('div'); //子要素を取得

    let condition = cld.text(); // 見たい商品を取得する

    if (~condition.indexOf('出品した商品---出品中')) {
      if ($('.mypage-block')[0] || !$('.mypage-side-bar-lists__list')[0]) return false; //ユーザーマイページではないなら以降実行しない。
      
      mypage.click();

      setTimeout(function(){
        $("#selling").click();
      },200);

    } else if (~condition.indexOf('出品した商品---取引中')) {
      if ($('.mypage-block')[0] || !$('.mypage-side-bar-lists__list')[0]) return false; //ユーザーマイページではないなら以降実行しない。
      
      mypage.click();

      setTimeout(function(){
        $("#selling_progress").click();
      },200);

    } else if (~condition.indexOf('出品した商品---売却済み')) {
      if ($('.mypage-block')[0] || !$('.mypage-side-bar-lists__list')[0]) return false; //ユーザーマイページではないなら以降実行しない。

      mypage.click();
      
      setTimeout(function(){
        $("#sold").click();
      },200);

    } else if (~condition.indexOf('購入した商品---取引中')) {
      if ($('.mypage-block')[0] || !$('.mypage-side-bar-lists__list')[0]) return false; //ユーザーマイページではないなら以降実行しない。
      
      mypage.click();
      
      setTimeout(function(){
        $("#bought_progress").click();
      },200);

    } else if (~condition.indexOf('購入した商品---過去の取引')) {
      if ($('.mypage-block')[0] || !$('.mypage-side-bar-lists__list')[0]) return false; //ユーザーマイページではないなら以降実行しない。
      
      mypage.click();

      setTimeout(function(){
        $("#bought_past").click();
      },200);

    }

  });
  
});