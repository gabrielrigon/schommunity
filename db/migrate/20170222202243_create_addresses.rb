class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :district
      t.string :complement
      t.references :city, index: true, foreign_key: true
      t.references :institution, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
