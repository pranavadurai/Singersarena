class AddColumnDefaults < ActiveRecord::Migration[5.0]
  def change
    add_column :defaults, :icon_type,:string
    add_column :defaults, :logo_type,:string
    add_column :defaults, :default_dp_type,:string
  end
end
