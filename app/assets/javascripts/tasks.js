// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('click', '.task', function(e) {
  var taskId = e.target.getAttribute('data-task-id');
  $.ajax({
    url: '/tasks/' + taskId,
    data: { completed: !$(e.target).hasClass('completed')},
    method: 'PATCH'
  });
});

$(function() {
  $.ajax({
    url: '/event_stream',
    method: 'GET',
    success: function(data) {
      var source = new EventSource(data.url);
      source.addEventListener(data.eventName, function(msg) {
        var data = JSON.parse(msg.data);
        var $task = $("[data-task-id="+data.id+"]");
        data.completed ? $task.addClass("completed") : $task.removeClass("completed");
      });
    }
  });
});
