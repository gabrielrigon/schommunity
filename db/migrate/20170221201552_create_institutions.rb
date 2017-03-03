class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :company_name
      t.string :trading_name
      t.string :cnpj
      t.attachment :logo

      t.timestamps null: false
    end
  end
end
