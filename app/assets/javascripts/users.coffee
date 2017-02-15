$(document).on 'blur', '#check_email', () ->
  email =$('#check_email').val()
  $.ajax '/users/check_email',
    type: 'GET'
    dataType: 'text'
    data: { email: email}
    error: (jqXHR, textStatus, errorThrown) ->
      alert 'There was an error. Sorry.'
    success: (data, textStatus,jqXHR) ->
      if data == 'new'
        $('#signup_form').removeAttr("disabled")
      else
        $('#sign_up_error').html data
        $('#signup_form').attr("disabled",true)

$ ->
  $('#follow_button').on "ajax:success" , (e,data,status,xhr)  ->
    $('#follow_unfollow_button').html("<%= render('users/unfollow') %>")

$ ->
  $('#unfollow_button').on "ajax:success", (e,data,status,xhr)  ->
    $('#follow_unfollow_button').html "<%= raw render 'users/follow.js.coffee'  %>"
