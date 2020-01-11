$(function() {
  // parent_categoryが選択された時のアクション
  $('#parent_category').change(function() {
    // var val = $('#parent_category').val();
    // console.log(val); // 出力：123
    $.ajax({
      url: "/recipes/select_category",
      type: 'GET',
      data: { category_id: $('#parent_category').has('option:selected').val() }
    });
  });
});