class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.integer :author_id, null: false
      t.string :title, null: false
      t.text :text, null: false
      t.integer :comments_counter, null: false, default: 0
      t.integer :likes_counter, null: false, default: 0

      t.foreign_key :users, column:  :author_id
      t.index :author_id

      t.timestamps
    end
  end
end
