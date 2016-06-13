# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.edit-comment-link').click (e) ->
    e.preventDefault();
    comment_id = $(this).data('commentId')
    $('form#edit-comment-' + comment_id).show()
    $('#comment-' + comment_id).hide()
