$('#like_block<%= @song.id %>').html("<%= j render partial: 'songs/unlike', locals: {song: @song}%>");
