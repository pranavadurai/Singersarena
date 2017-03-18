//= require cable
//= require_self
//= require_tree .

this.App={}

App.cable = ActionCable.createConsumer("/message")

$ ->
  con_id =  $('#messages').data('conversation-id')

  App.messages = App.cable.subscriptions.create { channel:'MessagesChannel',conversation_id: con_id},
    received: (data) ->
      user_id = parseInt($('#message_user_id').val())
      console.log(user_id)
      console.log(data.user_id)
      if user_id == data.user_id
        $('#message_contain_box').append '<p class="text-right"><span class="badge badge-pill badge-info">'+data.message+'</span></p>'
      else
        $('#message_contain_box').append '<p class="text-left"><span class="badge badge-pill badge-warning">'+data.message+'</span></p>'
