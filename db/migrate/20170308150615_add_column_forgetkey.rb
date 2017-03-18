class AddColumnForgetkey < ActiveRecord::Migration[5.0]
  def change
    add_column :authentications, :forgetkey, :string
  end
end
