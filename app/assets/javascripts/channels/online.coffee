messages = $('#messages')
if messages
    jQuery(document).on 'turbolinks:load', ->
      App.personal_chat = App.cable.subscriptions.create {
        channel: "OnlinesChannel"
      },
      received: (data) ->
         user = $(".user-#{data['user_id']}")
         user.toggleClass 'online', data['online']
return false
