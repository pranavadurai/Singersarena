class ChangeColumnToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :msga, :boolean, default: true
    change_column :users, :viemail, :boolean, default: true
    change_column :users, :viphone, :boolean, default: true
    change_column :users, :is_singer, :boolean, default: true
  end
end
