$(document).on('turbolinks:load', function() {
  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function appendOption(category){
      // var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
      var html = `<option value="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendChidrenBox(insertHTML){ // 子セレクトボックスのhtml作成
      var childSelectHtml = '';
        childSelectHtml = `<div class='recipe-select-wrapper__box' id= 'children_wrapper'>
                            <select class="recipe-select-wrapper__box--select" id="child_category" name="recipe[category_id]">
                              <option value="---" data-category="---">---</option>
                              ${insertHTML}
                            </select>
                          </div>`;
                        
      $('.recipe-select-wrapper').append(childSelectHtml);
    }
    // 親カテゴリー選択後のイベント
    $("#parent_category").on("change", function(){  // 親セレクトボックスの選択肢を変えたらイベント発火
      var recipecategory = document.getElementById("parent_category").value; 
      // ↑ recipecategoryに選択した親のvalueを代入
      if (recipecategory != ''){
      // ↑ recipecategoryが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢'---'に変えると､通信失敗となってしまうため｡
        $.ajax({
          url: '/recipes/category_children',
          type: 'GET',
          data: { parent_name: recipecategory },
          dataType: 'json'
        })
        .done(function(children){ // 送られてきたデータをchildrenに代入
          // $('#children_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
          // forEachでchildに一つずつデータを代入｡子のoptionが一つずつ作成される｡
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
          $("#parent_category").on('change', function(){
            // 通信成功時に親の選択肢を変えたらイベント発火｡子と孫を削除｡selectのidにかけるのではなく､親要素にかけないと残ってしまう
            $('#children_wrapper').remove(); 
          })
        })
        .fail(function(){
          alert('カテゴリーを選択して下さい');
        })
      }
    });
  });
});
