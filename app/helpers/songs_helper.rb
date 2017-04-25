module SongsHelper

  def song_play(song_id)
    url_for( :action => "song",:id => song_id, :controller=> "songs" )
  end
  
end
