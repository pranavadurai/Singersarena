# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new_message').on("ajax:success", (e,data,status,xhr) ->
    $('#message_body').val(" ") 
).on "ajax:error", (e, xhr, status, error) ->
    console.log error
