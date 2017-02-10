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

$ ->
  $('#new_comment').on("ajax:success", (e,data,status,xhr) ->
    $('#comment_display').prepend  '<li id="comment'+data.id+'" class="list-group-item"><div class="col-10">'+data.comment+'</div><div class="col-2"> <a data-confirm="Are you sure ??" class="fa fa-times comment_delete" data-remote="true" rel="nofollow" data-method="delete" href="/comments/'+data.id+'"> </a></div></li>'
    $('#comment').val(" ")
    $('#comment_count').html(parseInt($('#comment_count').text())+1)
).on "ajax:error", (e, xhr, status, error) ->
    console.log error

$ ->
  $('.comment_delete').on("ajax:success", (e,data,status,xhr) ->
    alert "Comment deleted."
    $("#comment"+data).remove()
    $('#comment_count').html(parseInt($('#comment_count').text())-1)
).on "ajax:error", (e, xhr, status, error) ->
    console.log error
