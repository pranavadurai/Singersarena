$ ->
  $(document).on 'change', '.song_filter', () ->
      language = $('#language_filter').val()
      category = $('#category_filter').val()
      $.ajax '/songs',
      type:'get'
      data:{language: language,category: category }
      dataType: 'script'


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
