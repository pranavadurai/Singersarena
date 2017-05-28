$('.message_container').html("<%= j render('conversations/get_message') %>").trigger('turbolinks:load');
 
