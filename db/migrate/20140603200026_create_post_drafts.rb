class CreatePostDrafts < ActiveRecord::Migration
  def change
    create_table :post_drafts do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :subject_id
      t.integer :category_id
      t.string :title
      t.text :body
      t.string :tags
      t.string :view_type
      t.integer :main_image
      t.string :comment_permission

      t.timestamps
    end
  end
end
