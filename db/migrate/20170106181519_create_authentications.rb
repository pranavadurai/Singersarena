class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.string :email
      t.string :password
      t.boolean :is_admin, default: false
      t.string :remember_token
      t.integer :user_id

      t.timestamps
    end
  end
end
