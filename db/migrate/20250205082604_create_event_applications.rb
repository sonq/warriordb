# db/migrate/[timestamp]_create_event_applications.rb
class CreateEventApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :event_applications do |t|
      t.references :event, null: false, foreign_key: true
      t.references :warrior, null: false, foreign_key: true
      t.string :status, limit: 20, default: 'pending'
      t.boolean :gi, default: false
      t.boolean :nogi, default: false
      t.boolean :mma, default: false
      t.decimal :weight, precision: 5, scale: 2
      t.text :notes

      t.timestamps
      
      t.index [:event_id, :warrior_id], unique: true
    end
  end
end