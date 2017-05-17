class CreateUserChats < ActiveRecord::Migration
  def change
    create_table :user_chats do |t|
      t.references :user, index: true, foreign_key: true
      t.references :contact, index: true, references: :users
      t.text :message
      t.boolean :read

      t.timestamps null: false
    end

    add_foreign_key :user_chats, :users, column: :contact_id
  end
end
