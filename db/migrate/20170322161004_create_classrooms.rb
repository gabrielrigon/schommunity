class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.references :institution, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :classroom_time, index: true, foreign_key: true
      t.references :representative, index: true, references: :users
      t.references :substitute_representative, index: true, references: :users
      t.references :teacher, index: true, references: :users
      t.references :helper, index: true, references: :users
      t.string :uuid
      t.text :description
      t.boolean :active, default: true

      t.timestamps null: false
    end

    add_foreign_key :classrooms, :users, column: :representative_id
    add_foreign_key :classrooms, :users, column: :teacher_id
    add_foreign_key :classrooms, :users, column: :helper_id
    add_foreign_key :classrooms, :users, column: :substitute_representative_id
  end
end
