$(document).on('turbolinks:load', function() {
  $(function(){
    $("img.small-photo").mouseover(function(){
    var selectedSrc = $(this).attr('src').replace(/^(.+)_thumb(\.gif|\.jpg|\.png+)$/, "$1"+"$2");
      $('img.big-photo').stop().fadeOut(50,
        function(){
          $('img.big-photo').attr('src', selectedSrc);
          $('img.big-photo').stop().fadeIn(1000);
        }
      );
    });
  });
});
