class CreateDefaults < ActiveRecord::Migration[5.0]
  def change
    create_table :defaults do |t|
      t.binary :icon
      t.binary :logo
      t.binary :default_db

      t.timestamps
    end
  end
end
