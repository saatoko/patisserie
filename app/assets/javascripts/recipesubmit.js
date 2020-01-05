// $(function() {
//   // form が submit されたとき
//   $("form").submit(function() {
//     var self = this;
//     $(":submit", self).prop("disabled", true);
//     setTimeout(function() {
//       $(":submit", self).prop("disabled", false);
//     }, 10000);

//     $('#cake').on('click', '.account-btn', function() {
//       // 同じ処理が二度走らないように、submitイベントを消してからsubmit
//         form.off( 'submit' );
//       form.submit();
//       });
//     // 自動でsubmitされないように処理を止める
//     return false;
//   });
// });


// $(function() {
//   //submitするform要素のname値を指定
//   var form = $('form[name=form-main]');
//   form.submit( function( e ) {
//     //1秒遅れで同じ処理が二度走らないように、submitイベントを消してからsubmit
//   setTimeout( function() {
//             form.off( 'submit' );
//             form.submit();
//             });
//   //自動でsubmitされないように処理を止める
//   return false;
//   });
// });


// $('form').submit(function (event) {
//   var form = $(this);
//   if (form.attr('.double')) {
//     // .doubleがついているなら、無視する。
//     event.preventDefault();
//   } else if (confirm('送信しますか？')) {
//     // 送信する。formに.double="1"をつける
//     form.attr('.double', "1");
//   } else {
//     // 送信しない。まだsubmitできる。
//     event.preventDefault();
//   }
// });

