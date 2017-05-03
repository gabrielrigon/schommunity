class CreateClassroomUsers < ActiveRecord::Migration
  def change
    create_table :classroom_users do |t|
      t.references :classroom, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :approved, default: true

      t.timestamps null: false
    end
  end
end
