class CreateWarriors < ActiveRecord::Migration[8.0]
  def change
    create_table :warriors do |t|
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.date :date_of_birth
      t.decimal :weight
      t.string :belt_rank, limit: 20
      t.integer :experience_years
      t.boolean :gi_practitioner
      t.boolean :nogi_practitioner
      t.string :phone, limit: 20
      t.references :user, null: false, foreign_key: true
      t.references :academy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
