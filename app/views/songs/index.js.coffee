$('#songs_display').append("<%= j render partial:'songshow' %>");
<% if @songs.next_page %>
$('#infinite-scrolling').replaceWith('<%= j will_paginate @songs %>');
<% else %>
$('.pagination').remove();
<% end %>
 
