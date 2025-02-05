class CreateAcademies < ActiveRecord::Migration[8.0]
  def change
    create_table :academies do |t|
      t.string :name, limit: 100
      t.string :phone, limit: 20
      t.text :address
      t.string :email, limit: 100

      t.timestamps
    end
  end
end
