class CreateClassroomTimes < ActiveRecord::Migration
  def change
    create_table :classroom_times do |t|
      t.string :name
      t.string :initial
      t.string :alias

      t.timestamps null: false
    end
  end
end
