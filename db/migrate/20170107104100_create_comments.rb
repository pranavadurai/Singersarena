class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :song_id
      t.text :comment
      t.integer :likes,array: true,default: []
      t.boolean :visible,default: true

      t.timestamps
    end
  end
end
