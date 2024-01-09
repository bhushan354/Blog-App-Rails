class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      # Add indexes for foreign keys
      t.index :post_id
      t.index :user_id

      t.foreign_key :posts, column: :post_id
      t.foreign_key :users, column: :user_id

      t.timestamps
    end
  end
end
