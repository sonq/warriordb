# app/models/division.rb
class Division < ApplicationRecord
  belongs_to :event
  belongs_to :gender
  belongs_to :division_status

  CATEGORIES = [ "gi", "nogi", "mma" ].freeze

  validates :name, presence: true, uniqueness: { scope: :event_id }
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :belt_rank, presence: true
  validates :min_weight, :max_weight, :min_age, :max_age, presence: true,
            numericality: { greater_than: 0 }
end
