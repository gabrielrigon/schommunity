class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :institution, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true
      t.references :post_type, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.boolean :active

      t.timestamps null: false
    end
  end
end
