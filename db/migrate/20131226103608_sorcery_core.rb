class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password, :null => false
      t.string :salt,             :null => false
      t.string :nickname
      t.string :role,							:default => "user"
      t.integer :posts_count,			:dafault => 0
      t.integer :comments_count,	:dafault => 0

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end