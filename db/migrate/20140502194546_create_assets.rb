class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.string :filename
      t.string :content_type
      t.string :filesize
      t.string :dimensions

      t.timestamps
    end
  end
end
