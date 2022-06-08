class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, presence: true
      t.string :email, presence: true, uniqueness: true
      t.string :password_digest, presence: true
      t.string :avatar_name
      t.text :introduction

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
