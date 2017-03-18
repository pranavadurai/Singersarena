$ ->
  $(document).on 'click', '#followers', () ->
    $('#user_show_page_container').html("<%= escape_javascript(render('users/followers')) %>")

  $(document).on 'click', '#followeds', () ->
    $('#user_show_page_container').html("<%= j render('users/following') %>")

  $(document).on 'click', '#my_songs', () ->
    $('#user_show_page_container').html("<%= j render('users/songshow') %>")
