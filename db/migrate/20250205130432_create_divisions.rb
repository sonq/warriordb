class CreateDivisions < ActiveRecord::Migration[8.0]
  def change
    create_table :divisions do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name, limit: 100, null: false
      t.references :gender, null: false, foreign_key: true
      t.string :belt_rank, limit: 20, null: false
      t.decimal :min_weight, precision: 5, scale: 2
      t.decimal :max_weight, precision: 5, scale: 2
      t.integer :min_age
      t.integer :max_age
      t.string :category, limit: 20, null: false
      t.references :division_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
