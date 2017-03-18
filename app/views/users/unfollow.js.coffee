$('#follow_unfollow_button').html("<%= j render('users/follow') %>")
$('#follower_count').html(parseInt($('#follower_count').text())-1)
