class CreateEventApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :event_applications do |t|
      t.references :event, null: false, foreign_key: true
      t.references :warrior, null: false, foreign_key: true
      t.string :status, limit: 20
      t.boolean :gi
      t.boolean :nogi
      t.boolean :mma
      t.decimal :weight
      t.text :notes

      t.timestamps
    end
  end
end
