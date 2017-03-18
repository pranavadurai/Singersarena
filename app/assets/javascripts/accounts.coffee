# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'blur', '#check_email', () ->
  email =$('#check_email').val()
  $.ajax '/accounts/check_email',
    type: 'GET'
    dataType: 'text'
    data: { email: email}
    error: (jqXHR, textStatus, errorThrown) ->
      alert 'There was an error. Sorry.'
    success: (data, textStatus,jqXHR) ->
      if data == 'new'
        $('#sign_up_error').html " "
        $('#check_email').parent().removeClass("has-danger")
        $('#check_email').removeClass("form-control-danger")
        $('#check_email').parent().addClass("has-success")
        $('#check_email').addClass("form-control-success")
        $('#signup_form').attr("disabled",false)
      else
        $('#sign_up_error').html data
        $('#check_email').parent().addClass("has-danger")
        $('#check_email').addClass("form-control-danger")
        $('#signup_form').attr("disabled",true)


$(document).on 'blur', '#email_check', () ->
  email =$('#email_check').val()
  $.ajax '/accounts/email_check',
    type: 'GET'
    dataType: 'text'
    data: { email: email}
    error: (jqXHR, textStatus, errorThrown) ->
      alert 'There was an error. Sorry.'
    success: (data, textStatus,jqXHR) ->
      if data == 'new'
        $('#sign_in_error').html " "
        $('#email_check').parent().removeClass("has-danger")
        $('#email_check').removeClass("form-control-danger")
        $('#email_check').parent().addClass("has-success")
        $('#email_check').addClass("form-control-success")
        $('#signin_form').attr("disabled",false)
      else
        $('#sign_in_error').html data
        $('#email_check').parent().addClass("has-danger")
        $('#email_check').addClass("form-control-danger")
        $('#signin_form').attr("disabled",true)
$ ->
  $('#forget_password').on("ajax:success",(e,data,status,xhr) ->
     $('#password_reset_msg').html data
).on "ajax:error", (e,xhr,error,status) ->
      console.log error
