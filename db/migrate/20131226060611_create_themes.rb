class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name
      t.integer :posts_count
      t.integer :view_count

      t.timestamps
    end
  end
end
