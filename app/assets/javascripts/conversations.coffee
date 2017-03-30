# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#message_contain_box').load ->
  $('#message_contain_box').animate({scrollTop: $('#message_contain_box').prop("scrollHeight")},1000)

$(document).on 'click', '.sshow_message', () ->
  conversation_id = $(this).attr('id')
  $.ajax '/conversations/get_message',
  type: 'GET',
  data: {conversation_id: conversation_id},
  dataType: 'text'
  success: (data) ->
    $('.message_container').html data
