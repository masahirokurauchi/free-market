document.addEventListener('turbolinks:load', function () {
  if (!$('#item_form')[0]) return false; //商品出品・編集ページではないなら以降実行しない。

  //灰色の箱をクリックしたら
  $("#select-image-button").on("click", function(){
  	const file_field = $("#item_images_attributes_0_src"); // 新規画像投稿用のfile_fieldを取得する。
    file_field.trigger("click"); // file_fieldをクリックさせる。

  });

  // //file_fieldが変化したら
  $("#image-file-fields").on("change", `input[type="file"]`, function (e) { //新しく画像が選択された、もしくは変更しようとしたが何も選択しなかった時
    console.table(e.target.files);
    
    const file = e.target.files[0];
    const blob_url = window.URL.createObjectURL(file); //選択された画像をblob url形式に変換する。
    
    const preview_html = `<img src="${blob_url}" width="20%">`; //プレビュー用HTML作成
    $("#select-image-button").before(preview_html); //灰色の箱の直前にアペンド
  });
  
});