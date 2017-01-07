class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :category
      t.string :language
      t.string :song
      t.integer :user_id
      t.integer :likes,array: true,default: []
      t.integer :fav,array: true,default:[]
      t.boolean :visible,default: true

      t.timestamps
    end
  end
end
