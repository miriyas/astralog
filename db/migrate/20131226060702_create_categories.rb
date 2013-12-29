class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :subject_id
      t.integer :parent_id
      t.string :view_type
      t.string :posts_count, :default => 0
      t.integer :position
			t.string :role

      t.timestamps
    end
  end
end
