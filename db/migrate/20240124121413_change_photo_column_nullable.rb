class ChangePhotoColumnNullable < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :photo, :string, null: true
  end
end
