class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
			t.string :style
      t.string :name
      t.integer :categories_count, :default => 0
      t.integer :posts_count, :default => 0
      t.integer :view_count, :default => 0

      t.timestamps
    end
  end
end
