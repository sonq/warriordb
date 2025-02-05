class CreateDivisionStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :division_statuses do |t|
      t.string :name, limit: 50, null: false
      t.timestamps
      t.index :name, unique: true
    end
  end
end
