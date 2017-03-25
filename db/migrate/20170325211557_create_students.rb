class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :user, index: true, foreign_key: true
      t.references :institution, index: true, foreign_key: true
      t.string :student_number
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
