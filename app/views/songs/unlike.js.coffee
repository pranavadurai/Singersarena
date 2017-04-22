$('#like_block<%= @song.id %>').html("<%= j render partial: 'songs/like', locals: {song: @song}%>");
