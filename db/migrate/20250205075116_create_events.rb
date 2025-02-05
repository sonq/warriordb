class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name, limit: 100
      t.date :date
      t.string :location, limit: 100
      t.date :registration_deadline
      t.text :description
      t.boolean :gi
      t.boolean :nogi
      t.boolean :mma
      t.references :event_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
