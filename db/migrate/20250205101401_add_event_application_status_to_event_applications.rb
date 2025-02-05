class AddEventApplicationStatusToEventApplications < ActiveRecord::Migration[8.0]
  def change
    remove_column :event_applications, :status, :string
    add_reference :event_applications, :event_application_status, null: false, foreign_key: true
  end
end