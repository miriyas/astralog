class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :subject_id
      t.integer :category_id
      t.integer :comments_count
      t.string :title
      t.text :body
      t.string :tags
      t.string :status
      t.string :view_type
      t.integer :view_count
      t.integer :main_image
      t.string :comment_permission

      t.timestamps
    end
  end
end
