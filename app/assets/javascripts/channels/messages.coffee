//= require cable
//= require_self
//= require_tree .

this.App={}

App.cable = ActionCable.createConsumer("/message")

$ ->
  con_id =  $('#messages').data('conversation-id')
  console.log(con_id)

  App.messages = App.cable.subscriptions.create { channel:'MessagesChannel',conversation_id: con_id},
    received: (data) ->
      $('#messages').append '<p><b>'+data.user_name+'</b>'+data.message+'</p>'
