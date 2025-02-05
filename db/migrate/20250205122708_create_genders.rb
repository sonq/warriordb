# db/migrate/[timestamp]_create_genders.rb
class CreateGenders < ActiveRecord::Migration[8.0]
  def change
    create_table :genders do |t|
      t.string :name, limit: 20, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
