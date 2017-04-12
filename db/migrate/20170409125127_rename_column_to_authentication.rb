class RenameColumnToAuthentication < ActiveRecord::Migration[5.0]
  def change
    rename_column :authentications, :password,:password_digest
  end
end
