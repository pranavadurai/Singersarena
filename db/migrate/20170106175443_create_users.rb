class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.bigint :phone
      t.string :gender
      t.string :city
      t.string :country
      t.binary :pic
      t.string :pictype
      t.string :dpic
      t.text :aboutme
      t.boolean :msga
      t.boolean :viemail
      t.boolean :viphone
      t.boolean :is_singer
      t.json :tag_hear
      t.json :tag_sing

      t.timestamps
    end
  end
end
