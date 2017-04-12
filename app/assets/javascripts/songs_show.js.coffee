
#$ ->
#  $(window).on 'scroll', ->
#    more_posts_url = $('.pagination .next_page').attr('href')
#    if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
#      $('.pagination').html('<p>Loading......</p>')
#      $.getScript more_posts_url
#    return
