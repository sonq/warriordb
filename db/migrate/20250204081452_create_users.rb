class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, limit: 100
      t.string :password_digest, limit: 255
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.integer :role
      t.string :phone, limit: 20

      t.timestamps
    end
  end
end
