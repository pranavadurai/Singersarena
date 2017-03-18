class AddColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :song_in, :binary
  end
end
