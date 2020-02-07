$(document).on('turbolinks:load', function() {
  $fileField = $('#upload-video')
  $($fileField).change(function(e) {

    var file = e.target.files[0]
    // FileReaderオブジェクトを生成する
    var file_reader = new FileReader();
    $preview = $('#video-icon');

    file_reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<video>').attr({
          src: e.target.result,
          width: "45%",
          height: "140px",
          class: "preview-video",
          autoplay: "autoplay",
          loop: "loop",
          playsinline: "true",
          // title: file.name 
        }));
      };
    })(file);
    // DataURIScheme文字列を取得
    file_reader.readAsDataURL(file);
  });
});

