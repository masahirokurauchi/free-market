document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。

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


  $(".input-field-main").on("change", ".select-category", function () { //カテゴリが選択された時
    const category_id = $(this).val();
    var changed_form = $(this); //thisを保持

    $.ajax({ //category_idをAJAXで送信
        url: "/api/categories",
        type: "GET",
        data: {
          category_id: category_id
        },
        dataType: 'json',
      }).done(function (categories) {
      	if (categories.length == 0) return false //categoryが空、つまり孫が選択された場合、処理を終了させる。

      	changed_form.nextAll(".select-category").remove(); //選択肢たカテゴリ以降のカテゴリを全て消去。カテゴリの選び直し対策。

        const html = buildCategoryForm(categories);// カテゴリのフォームを組み立てる
        $(".select-category:last").after(html);// 組み立てたフォームを表示
      })
      .fail(function () {
        alert('error');
      })
  });
});