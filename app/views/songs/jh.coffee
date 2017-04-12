$('#songs_display').html("<%= j render partial: 'songs/songshow', :collection => @songs,:layout => false %>");
