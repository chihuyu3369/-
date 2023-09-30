class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id, null: false
      t.text :post_content, null: false
      t.string :title, null: false
      t.string :post_photo, null: false
      t.timestamps null: false
    end
  end
end
