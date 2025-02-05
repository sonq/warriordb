class AddIsDefaultToEventApplicationStatus < ActiveRecord::Migration[8.0]
  def change
    add_column :event_application_statuses, :is_default, :boolean, default: false
    
    # Add the default status and update existing applications
    reversible do |dir|
      dir.up do
        # Create or find 'Beklemede' status and set it as default
        default_status = EventApplicationStatus.find_or_create_by!(name: 'Beklemede') do |status|
          status.is_default = true
        end
        
        # Update any existing applications without a status
        execute <<-SQL
          UPDATE event_applications 
          SET event_application_status_id = #{default_status.id}
          WHERE event_application_status_id IS NULL
        SQL
      end
    end
  end
end