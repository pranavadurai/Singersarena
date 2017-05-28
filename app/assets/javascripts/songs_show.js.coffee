
$ ->
    $(window).on 'scroll', ->
        more_posts_url = $('.pagination .next_page').attr('href')
        if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html('<p>Loading......</p>')
          $.ajax more_posts_url,
          type: 'get'
          dataType: 'script'
        return
