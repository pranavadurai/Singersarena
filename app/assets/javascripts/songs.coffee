$(document).on 'click', '.like_unlike', () ->
  song_id  = $(this).attr('id').substr(4,1)
  fun_click = $(this).attr('id').substr(0,4)
  if fun_click == 'like'
    url = '/songs/like'
  else
    url = '/songs/unlike'
  $.ajax url,
    type: 'GET'
    dataType: 'text'
    data: { song_id: song_id}
    error: (jqXHR, textStatus, errorThrown) ->
      alert 'There was an error. Sorry.'
    success: (data, textStatus,jqXHR) ->
      $('#'+fun_click+song_id).remove()
      $('#like_block'+song_id).append data
