class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :initials
      t.text :description
      t.references :coordinator, index: true, references: :users
      t.references :institution, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_foreign_key :courses, :users, column: :coordinator_id
  end
end
