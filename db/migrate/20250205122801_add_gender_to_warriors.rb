class AddGenderToWarriors < ActiveRecord::Migration[8.0]
  def change
    add_reference :warriors, :gender, null: false, foreign_key: true
  end
end
