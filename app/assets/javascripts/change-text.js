$(document).on('turbolinks:load', function() {
  $(function(){
    $('#change-open').hover(function(){
      $(this).text('Open');
      $(this).css('font-family', 'cursive');
      $(this).css('letter-spacing', '2.7rem');
      $(this).css('font-size', '4.7rem');
    });
    $('#change-open').mouseout(function(){
      $(this).text('お菓子好き 集合!!');
      $(this).css('font-family', 'serif');
      $(this).css('letter-spacing', '1.7rem');
      $(this).css('font-size', '4.0rem');
    });
  });
});
  