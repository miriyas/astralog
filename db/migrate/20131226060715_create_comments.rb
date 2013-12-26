class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :body
      t.string :user_ip
      t.string :type
      t.integer :parent_id

      t.timestamps
    end
  end
end
