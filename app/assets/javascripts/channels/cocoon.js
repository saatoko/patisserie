$(document).ready(function() {
  $('#ingredients')
    .on('cocoon:before-insert', function(e,task_to_be_added) {
      task_to_be_added.fadeIn('slow');
    })
    .on('cocoon:after-insert', function(e, added_task) {
      added_task.css("background","rgba(255, 233, 204, 0.897)");
    })
    .on('cocoon:before-remove', function(e, task) {
      $(this).data('remove-timeout', 1000);
      task.fadeOut('slow');
    });
  
  $('#ingredients').on('cocoon:before-remove', function(event, removedItem) {
    var confirmation = confirm("本当に削除しますか?");
    if( confirmation === false ){
      event.preventDefault();
    }
  });
});