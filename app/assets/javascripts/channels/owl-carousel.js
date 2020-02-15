$(document).on('turbolinks:load', function() { 
  $(function(){
    var owl = $('.sweets-banner.owl-carousel');
    owl.owlCarousel({
      items: 8,
      autoWidth:true, //幅を指定したサイズにする
      autoHeight:true, //高さを指定したサイズにする
      loop:true,
      margin:30,
      autoplay:true,
      autoplayTimeout:5000,
      autoplayHoverPause:true
    });
    $('.play').on('click',function(){
      owl.trigger('play.owl.autoplay',[5000])
    })
    $('.stop').on('click',function(){
      owl.trigger('stop.owl.autoplay')
    })
  });
});  