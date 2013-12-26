class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :theme_id
      t.integer :parent_id
      t.string :view_type
      t.string :posts_count
      t.integer :position

      t.timestamps
    end
  end
end
