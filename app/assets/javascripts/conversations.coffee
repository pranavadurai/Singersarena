# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
$('#message_contain_box').load ->
  $('#message_contain_box').animate({scrollTop: $('#message_contain_box').prop("scrollHeight")},1000)
