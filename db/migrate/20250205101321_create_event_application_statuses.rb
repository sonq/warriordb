# db/migrate/[timestamp]_create_event_application_statuses.rb
class CreateEventApplicationStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :event_application_statuses do |t|
      t.string :name, limit: 50, null: false

      t.timestamps
      
      t.index :name, unique: true
    end
  end
end