class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.text :text

      t.foreign_key :users, column: :user_id
      t.foreign_key :posts, column: :post_id
      
      # Add indexes for foreign keys
      t.index :user_id
      t.index :post_id
      
      t.timestamps
    end
  end
end
