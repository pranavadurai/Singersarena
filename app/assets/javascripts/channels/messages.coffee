//= require cable
//= require_self
//= require_tree .

this.App={}

App.cable = ActionCable.createConsumer("/message")

get_message = () ->
    messages = $('#messages')
    if messages
        con_id   =  $('#messages').data('conversation-id')
        messages_to_bottom = -> $('#message_contain_box').animate({scrollTop: $('#message_contain_box').prop("scrollHeight")},1000)
        messages_to_bottom()
        App.messages = App.cable.subscriptions.create { channel:'MessagesChannel',conversation_id: con_id},
          received: (data) ->
            user_id = parseInt($('#message_user_id').val())
            if user_id == data.user_id
              $('#message_contain_box').append '<p class="text-right"><span class="badge badge-pill badge-info">'+data.message+'</span></p>'
            else
              $('#message_contain_box').append '<p class="text-left"><span class="badge badge-pill badge-warning">'+data.message+'</span></p>'
            messages_to_bottom()
            $('#message_body').val(" ")

jQuery(document).on 'turbolinks:load', ->
  $ -> get_message()
