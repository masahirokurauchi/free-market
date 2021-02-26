document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //商品出品ページでないなら以降実行しない。

  function buildCategoryForm(categories) { // 子孫カテゴリのフォームを組み立てる
    let options = "";
    categories.forEach(function (category) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });

    const html = `
                  <select required="required" class="select-category" name="item[category_id]">
                    <option value="">---</option>
                    ${options}
                  </select>
                 `;
    return html;
  }


  $("#item_price").on("keyup", function () { //価格が入力された時

    let price = $(this).val();
    let fee = price / 10;

    if ($.isNumeric(price) && (price >= 300) ) { //　数字かつ３００円以上なら
        console.log(fee);
    } else if ($.isNumeric(price)) { // 数字かつ３００円以下なら
    } else { // 数字でないなら

    }

    

    
  });
});