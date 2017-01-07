class AddSongTypeToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :song_type, :string
  end
end
